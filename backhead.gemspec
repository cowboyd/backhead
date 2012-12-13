# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backhead/version'

Gem::Specification.new do |gem|
  gem.name          = "backhead"
  gem.version       = Backhead::VERSION
  gem.authors       = ["Charles Lowell"]
  gem.email         = ["cowboyd@thefrontside.net"]
  gem.description   = %q{removes the tedium of defining rails engine configuration options}
  gem.summary       = %q{specify which configuration options your engine supports. Optionally set them with environment variables}
  gem.homepage      = "https://github.com/cowboyd/backhead"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '>= 3'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-spies'
end
