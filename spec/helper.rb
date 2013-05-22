require 'simplecov'
require 'coveralls'
require 'rspec'
require 'webmock/rspec'
require 'ffaker'
require 'yotpo'


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do

  end
end

def a_delete(path)
  a_request(:delete, 'https://api.yotpo.com' + path)
end

def a_get(path)
  a_request(:get, 'https://api.yotpo.com' + path)
end

def a_post(path)
  a_request(:post, 'https://api.yotpo.com' + path)
end

def a_put(path)
  a_request(:put, 'https://api.yotpo.com' + path)
end

def stub_delete(path)
  stub_request(:delete, 'https://api.yotpo.com' + path)
end

def stub_get(path)
  stub_request(:get, 'https://api.yotpo.com' + path)
end

def stub_post(path)
  stub_request(:post, 'https://api.yotpo.com' + path)
end

def stub_put(path)
  stub_request(:put, 'https://api.yotpo.com' + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end