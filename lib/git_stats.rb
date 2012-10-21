module GitStats
end

require 'active_support/all'
require 'action_pack'
require 'action_view'
require 'fileutils'
require 'tilt'
#require 'lazy_high_charts'
require 'launchy'
require 'i18n'

require 'bundler'
Bundler.require(:default)
Dir['lib/**/*.rb'].each { |r| require File.expand_path(r) }