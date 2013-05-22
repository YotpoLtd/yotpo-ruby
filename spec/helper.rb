require 'simplecov'
require 'coveralls'
require 'rspec'
require 'webmock/rspec'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start

