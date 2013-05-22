# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('yotpo/version', lib)

Gem::Specification.new do |gem|
  gem.name          = 'yotpo'
  gem.version       = Yotpo::VERSION
  gem.authors       = ['Vladislav Shub']
  gem.email         = %w(vlad@yotpo.com)
  gem.description   = %q{Connector to the yotpo api}
  gem.summary       = %q{Connector to the yotpo api}
  gem.homepage      = 'https://github.com/YotpoLtd/yotpo-api-connector'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)

  gem.add_dependency 'faraday'
  gem.add_dependency 'typhoeus'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'rash'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'rake'
  gem.add_dependency 'oj'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'


end
