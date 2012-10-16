require 'simplecov'
SimpleCov.start

require 'git_stats'

require 'factory_girl'
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

