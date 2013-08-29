# -*- encoding : utf-8 -*-
require "git_stats"
require "thor"

class GitStats::CLI < Thor
  option :path, :aliases => :p, :default => '.', :desc => 'Path to repository from which statistics should be generated.'
  option :output, :aliases => :o, :default => './git_stats', :desc => 'Output path where statistics should be written.'
  option :language, :aliases => :l, :default => 'en', :desc => 'Language of written statistics.'
  option :from, :aliases => :f, :desc => 'Commit from where statistics should start.'
  option :to, :aliases => :t, :default => 'HEAD', :desc => 'Commit where statistics should stop.'
  option :silent, :aliases => :s, :type => :boolean, :desc => 'Silent mode. Don\'t output anything.'

  desc 'generate', 'Generates the statistics of a repository'
  def generate
    I18n.locale = options[:language]
    GitStats::Generator.new(options[:path], options[:output], options[:from], options[:to]) { |g|
      g.add_command_observer { |command, result| puts "#{command}" } unless options[:silent]
    }.render_all
  end

end
