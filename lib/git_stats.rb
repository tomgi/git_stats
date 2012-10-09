module GitStats
end

require 'active_support/all'
require 'action_pack'
require 'action_view'
require 'fileutils'
require 'pathname'
require 'tilt'
require 'lazy_high_charts'
require 'launchy'
Dir['lib/**/*.rb'].each { |r| require File.expand_path(r) }