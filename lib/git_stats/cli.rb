# -*- encoding : utf-8 -*-
require "git_stats"
require "thor"

class GitStats::CLI < Thor
  option :path, :aliases => :p, :default => '.', :desc => 'Path to repository from which statistics should be generated.'
  option :out_path, :aliases => :o, :default => './git_stats', :desc => 'Output path where statistics should be written.'
  option :language, :aliases => :l, :default => 'en', :desc => 'Language of written statistics.'
  option :first_commit_sha, :aliases => :f, :desc => 'Commit from where statistics should start.'
  option :last_commit_sha, :aliases => :t, :default => 'HEAD', :desc => 'Commit where statistics should stop.'
  option :silent, :aliases => :s, :type => :boolean, :desc => 'Silent mode. Don\'t output anything.'
  option :tree, :aliases => :d, :default => '.', :desc => 'Tree where statistics should be generated.'
  option :comment_string, :aliases => :c, :default => '//', :desc => 'The string which is used for comments.'
  
  desc 'generate', 'Generates the statistics of a repository'
  def generate
    I18n.locale = options[:language]
    GitStats::Generator.new(options) { |g|
      g.add_command_observer { |command, result| puts "#{command}" } unless options[:silent]
    }.render_all
  end

end
