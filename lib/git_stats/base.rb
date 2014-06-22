# -*- encoding : utf-8 -*-
require 'git_stats/core_extensions/hash'
require 'git_stats/core_extensions/string'
require 'git_stats/core_extensions/symbol'

require 'git_stats/version'
require 'git_stats/i18n'
require 'git_stats/by_field_finder'
require 'git_stats/cli'
require 'git_stats/generator'
require 'git_stats/validator'

require 'git_stats/git_data/activity'
require 'git_stats/git_data/author'
require 'git_stats/git_data/blob'
require 'git_stats/git_data/command_parser'
require 'git_stats/git_data/command_runner'
require 'git_stats/git_data/commit'
require 'git_stats/git_data/repo'
require 'git_stats/git_data/short_stat'
require 'git_stats/git_data/tree'

require 'git_stats/stats_view/template'
require 'git_stats/stats_view/view'
require 'git_stats/stats_view/view_data'

require 'git_stats/stats_view/charts/activity_charts'
require 'git_stats/stats_view/charts/authors_charts'
require 'git_stats/stats_view/charts/chart'
require 'git_stats/stats_view/charts/charts'
require 'git_stats/stats_view/charts/repo_charts'

