# -*- encoding : utf-8 -*-
require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Repo
      include HashInitializable

      delegate :files, :files_by_extension, :files_by_extension_count, :lines_by_extension,
               :files_count, :binary_files, :text_files, :lines_count, :comments_count, to: :last_commit

      def initialize(params)
        super(params)
        @path = File.expand_path(@path)
        @tree_path ||= "."
      end

      def path
        @path ||= '.'
      end

      def first_commit_sha
        @first_commit_sha
      end

      def last_commit_sha
        @last_commit_sha ||= 'HEAD'
      end

      def author_emails
        @author_emails ||= []
      end

      def tree_path
        @tree_path ||= '.'
      end

      def comment_string
        @comment_string ||= '//'
      end

      def tree
        @tree ||= Tree.new(repo: self, relative_path: @tree_path)
      end

      def authors
        emails = author_emails.map { |email| email.downcase }
        @authors ||= run_and_parse("git shortlog -se #{commit_range} #{tree_path}")
          .select { |author| emails.count == 0 ? true : emails.include?(author[:email].downcase) }
          .map { |author| Author.new(repo: self, name: author[:name], email: author[:email]) }
      end

      def commits
        @commits ||= run_and_parse("git rev-list --pretty=format:'%H|%at|%ai|%aE' #{commit_range} #{tree_path} | grep -v commit")
        .select { |commit_line| authors.select { |a| a.email == commit_line[:author_email] } .count > 0 }
        .map { |commit_line| Commit.new(
              repo: self,
              sha: commit_line[:sha],
              stamp: commit_line[:stamp],
              date: DateTime.parse(commit_line[:date]),
              author: authors.first! { |a| a.email == commit_line[:author_email] }
          )
        }
        .sort_by! { |e| e.date }
      end

      def commits_period
        commits.map(&:date).minmax
      end

      def commits_count_by_author(limit = 4)
        Hash[authors.map { |author| [author, author.commits.size] }.sort_by { |author, commits| -commits }[0..limit]]
      end

      [:insertions, :deletions, :changed_lines].each do |method|
        define_method "#{method}_by_author" do |limit = 4|
          Hash[authors.map { |author| [author, author.send(method)] }.sort_by { |author, lines| -lines }[0..limit]]
        end
      end

      def files_count_by_date
        @files_count_each_day ||= Hash[commits.map { |commit|
          [commit.date.to_date, commit.files_count]
        }]
      end

      def lines_count_by_date
        sum = 0
        @lines_count_each_day ||= Hash[commits.map { |commit|
          sum += commit.short_stat.insertions
          sum -= commit.short_stat.deletions
          [commit.date.to_date, sum]
        }]
      end

      def comments_count_by_date
        sum = 0
        @comment_count_each_day ||= Hash[commits.map { |commit|
          sum += commit.comment_stat.insertions
          sum -= commit.comment_stat.deletions
          [commit.date.to_date, sum]
        }].fill_empty_days!(aggregated: true)
      end

      def last_commit
        commits.last
      end

      def commit_range
        @first_commit_sha.blank? ? last_commit_sha : "#@first_commit_sha..#{last_commit_sha}"
      end

      def short_stats
        @short_stats ||= commits.map(&:short_stat)
      end

      def comment_stats
        @comment_stats ||= commits.map(&:comment_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def project_version
        @project_version ||= run("git rev-parse #{commit_range}").strip
      end

      def project_name
        @project_name ||= (File.expand_path(File.join(path, tree_path)).sub(File.dirname(File.expand_path(path))+File::SEPARATOR,"") || File.basename(path))
      end

      def run(command)
        result = command_runner.run(path, command)
        invoke_command_observers(command, result)
        result
      end

      def run_and_parse(command)
        result = run(command)
        command_parser.parse(command, result)
      end

      def command_runner
        @command_runner ||= CommandRunner.new
      end

      def command_parser
        @command_parser ||= CommandParser.new
      end

      def add_command_observer(proc=nil, &block)
        command_observers << block if block_given?
        command_observers << proc if proc
      end

      def to_s
        "#{self.class} #@path"
      end

      def ==(other)
        self.path == other.path
      end

      private
      def command_observers
        @command_observers ||= []
      end

      def invoke_command_observers(command, result)
        command_observers.each { |o| o.call(command, result) }
      end


    end
  end
end
