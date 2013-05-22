require 'yotpo/version'
require 'yotpo/client'

module Yotpo
  class << self
    attr_accessor :url, :parallel_requests, :app_key, :secret

    def configure
      yield self
      true
    end

    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end

    def client
      @client ||= Yotpo::Client.new()
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
