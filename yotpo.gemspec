# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require File.expand_path('yotpo/version', lib)

Gem::Specification.new do |gem|
  gem.name          = 'yotpo'
  gem.version       = Yotpo::VERSION
  gem.authors       = ['Vladislav Shub']
  gem.email         = %w(vlad@yotpo.com)
  gem.description   = %q{A Ruby interface to the YOTPO API}
  gem.summary       = %q{A Ruby interface to the YOTPO API}
  gem.homepage      = 'https://github.com/YotpoLtd/yotpo-ruby'
  gem.license       = 'MIT'
  gem.required_ruby_version = '>= 2.3.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)

  gem.add_dependency 'faraday'
  gem.add_dependency 'typhoeus'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'hashie'
  gem.add_dependency 'activesupport'
end
