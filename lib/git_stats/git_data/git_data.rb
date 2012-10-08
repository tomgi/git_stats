require 'pathname'
require 'git_stats/git_data/git_activity'
require 'git_stats/git_data/git_author'
require 'git_stats/git_data/git_commit'
require 'lazy_high_charts'

class GitStats::GitData
  include ActionView::Helpers::TagHelper
  include LazyHighCharts::LayoutHelper

  attr_reader :total_authors
  attr_reader :total_commits

  def initialize(repo_path)
    @repo_path = repo_path
  end

  def gather_all_data
    @total_authors = run('git shortlog -s HEAD | wc -l')

    gather_commit_data
  end

  def gather_commit_data
    run('git rev-list --pretty=format:"%h|%at|%ai|%aN|%aE" HEAD | grep -v commit').split(/\r?\n/).each do |commit|
      hash, stamp, date, author_name, author_email = commit.split('|')

      authors[author_email] = GitStats::GitAuthor.new(name: author_name, email: author_email) unless authors[author_email]
      author = authors[author_email]

      date = DateTime.parse(date)
      commits[hash] = GitStats::GitCommit.new(hash: hash, stamp: stamp, date: date, author: author)

      activity.by_hour[date.hour] += 1
      activity.by_wday[date.wday] += 1
      activity.by_wday_hour[date.wday][date.hour] += 1

      author.activity.by_hour[date.hour] += 1
      author.activity.by_wday[date.wday] += 1
      author.activity.by_wday_hour[date.wday][date.hour] += 1
    end

    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(type: "column")
      f.title(text: "Commits")
      f.xAxis(categories: Date::ABBR_DAYNAMES)
      f.yAxis(min: 0, title: {text: 'Commits'})
      f.legend(
          layout: 'vertical',
          backgroundColor: '#FFFFFF',
          align: 'left',
          verticalAlign: 'top',
          x: 100,
          y: 70,
          floating: true,
          shadow: true
      )
      authors.each do |email, author|
        f.series(:name => email, :data => author.activity.by_wday.inject([]) { |acc, (k, v)| acc[k] = v; acc })
      end
    end
  end

  def authors
    @authors ||= {}
  end

  def commits
    @commits ||= {}
  end

  def activity
    @activity ||= GitStats::GitActivity.new
  end

  def project_version
    @project_version ||= run('git rev-parse --short HEAD')
  end

  def project_name
    @project_name ||= Pathname(@repo_path).basename.to_s
  end

  def run(command)
    in_repo { %x[#{command}] }
  end

  def in_repo
    Dir.chdir(@repo_path) { yield }
  end
end
