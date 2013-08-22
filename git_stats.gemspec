# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_stats/version'

Gem::Specification.new do |gem|
  gem.name          = "git_stats"
  gem.version       = GitStats::VERSION
  gem.authors       = ["Tomasz Gieniusz"]
  gem.email         = ["tomasz.gieniusz@gmail.com"]
  gem.description   = %q{Git history statistics generator}
  gem.summary       = %q{HTML statistics generator from git repository}
  gem.homepage      = "https://github.com/tomgi/git_stats"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = Gem::Requirement.new(">= 1.9.2")

  gem.add_dependency('activesupport', '>= 4.0')
  gem.add_dependency('actionpack', '>= 4.0')
  gem.add_dependency('tilt', '>= 1.4')
  gem.add_dependency('haml', '>= 4.0')
  gem.add_dependency('lazy_high_charts', '>= 1.4')
  gem.add_dependency('i18n')
  gem.add_dependency('thor')
end
