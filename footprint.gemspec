# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'footprint/version'

Gem::Specification.new do |gem|
  gem.name          = "footprint"
  gem.version       = Footprint::VERSION
  gem.authors       = ["Subhash Bhushan"]
  gem.email         = ["subhash.bhushan@stratalabs.in"]
  gem.description   = %q{Big Data Versioning for those seriously Big Apps}
  gem.summary       = %q{Big Data Versioning for those seriously Big Apps}
  gem.homepage      = ""
  
  gem.add_development_dependency  "rspec", "~> 2.12"
  gem.add_development_dependency  "guard-rspec"
  gem.add_development_dependency  "growl", "~> 1.0.3"
  gem.add_development_dependency  "rb-fsevent", "~> 0.9.1"
  gem.add_development_dependency  "factory_girl"
  gem.add_development_dependency  "sqlite3"
  
  gem.add_dependency              "mongoid", "~> 3.0.0"
  gem.add_dependency              "activerecord", "~> 3.2.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
