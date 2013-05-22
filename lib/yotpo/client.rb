require 'active_support/notifications'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'faraday_middleware'
require 'yotpo/core/encode_oj'
require 'yotpo/core/parse_oj'
require 'yotpo/core/response_parser'
require 'yotpo/version'
require 'yotpo/api/account'
require 'yotpo/api/account_platform'
require 'yotpo/api/product'
require 'yotpo/api/reminder'
require 'yotpo/api/review'
require 'yotpo/api/user'

module Yotpo
  class Client
    include Yotpo::Review

    def initialize(url = 'https://api.yotpo.com', parallel_requests = 5)
      @url = url
      @parallel_requests = parallel_requests
    end

    def get(url, params = {})
      preform(url, :get, params: params) do
        return connection.get(url, params)
      end
    end

    def post(url, params)
      preform(url, :post, params: params) do
        return connection.post(url, params)
      end
    end

    def put(url, params)
      preform(url, :put, params: params) do
        return connection.put(url, params)
      end
    end

    def delete(url)
      preform(url, :delete) do
        return connection.delete(url)
      end
    end

    def in_parallel
      connection.in_parallel do
        yield
      end
    end

    private
    def preform(url, type, params = {}, &block)
      ActiveSupport::Notifications.instrument 'Yotpo', request: type, url: url, params: params do
        if connection.in_parallel?
          block.call
        else
          block.call.body
        end
      end
    end

    def connection
      @connection ||= Faraday.new(url: @url, parallel_manager: Typhoeus::Hydra.new(max_concurrency: @parallel_requests), headers: {:yotpo_api_connector => Yotpo::VERSION}) do |conn|

        conn.use Yotpo::ResponseParser

        # Set the response to be rashified
        conn.response :rashify

        # Setting request and response to use JSON/XML
        conn.request :oj
        conn.response :oj

        # Set to use instrumentals to get time logs
        conn.use :instrumentation

        conn.adapter :typhoeus
      end
    end
  end
end