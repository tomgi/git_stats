# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitstats/version'

Gem::Specification.new do |gem|
  gem.name          = "gitstats"
  gem.version       = Gitstats::VERSION
  gem.authors       = ["Tomasz Gieniusz"]
  gem.email         = ["tomasz.gieniusz@gmail.com"]
  gem.description   = %q{Git history statistics generator}
  gem.summary       = %q{HTML statistics generator from git repository}
  gem.homepage      = "https://github.com/tomgi/gitstats"
  gem.executables   = "gitstats"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('pry')
end
