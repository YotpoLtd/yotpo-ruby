require 'simplecov'
require 'coveralls'
require 'rspec'
require 'webmock/rspec'
require 'ffaker'
require 'yotpo'
require 'vcr'



SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_hosts 'coveralls.io'
  c.cassette_library_dir     = 'spec/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    @app_key = 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'
    @secret = 'YUFV3FrFHGbAJLPsOR8JebwUUhGJg9Z42XKj3Umm'
    VCR.use_cassette('get_oauth_token') do
      @utoken ||= Yotpo.get_oauth_token({ app_key: @app_key, secret: @secret }).body.access_token
    end
  end

  config.extend VCR::RSpec::Macros
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