require 'active_support/notifications'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'faraday_middleware'
require 'yotpo/core/response_parser'
require 'yotpo/version'
require 'yotpo/api/account'
require 'yotpo/api/account_platform'
require 'yotpo/api/product'
require 'yotpo/api/purchase'
require 'yotpo/api/reminder'
require 'yotpo/api/review'
require 'yotpo/api/user'

module Yotpo
  class Client
    include Yotpo::Account
    include Yotpo::AccountPlatform
    include Yotpo::Product
    include Yotpo::Reminder
    include Yotpo::Review
    include Yotpo::User

    include Yotpo::Purchase


    #
    # Creates a new instance of Yotpo::Client
    #
    # @param url [String] The url to yotpo api (https://api.yotpo.com)
    # @param parallel_requests [Integer String] The maximum parallel request to do (5)
    def initialize(url = 'https://api.yotpo.com', parallel_requests = 5)
      @url = url
      @parallel_requests = parallel_requests
    end

    #
    # Does a GET request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    # @param params [Hash] the url params that should be passed in the request
    def get(url, params = {})
      preform(url, :get, params: params) do
        return connection.get(url, params)
      end
    end

    #
    # Does a POST request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    # @param params [Hash] the body of the request
    def post(url, params)
      preform(url, :post, params: params) do
        return connection.post(url, params)
      end
    end

    #
    # Does a PUT request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    # @param params [Hash] the body of the request
    def put(url, params)
      preform(url, :put, params: params) do
        return connection.put(url, params)
      end
    end

    #
    # Does a DELETE request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    def delete(url)
      preform(url, :delete) do
        return connection.delete(url)
      end
    end

    #
    # Does a parallel request to the api for all of the requests in the block
    #
    # @example block
    #   Yotpo.in_parallel do
    #     Yotpo.create_review(review_params)
    #     Yotpo.update_account(account_params)
    #   end
    def in_parallel
      connection.in_parallel do
        yield
      end
    end

    private

    #
    # Preforms an HTTP request and notifies the ActiveSupport::Notifications
    #
    # @private
    # @param url [String] the url to which preform the request
    # @param type [String]
    def preform(url, type, params = {}, &block)
      ActiveSupport::Notifications.instrument 'Yotpo', request: type, url: url, params: params do
        if connection.in_parallel?
          block.call
        else
          block.call.body
        end
      end
    end

    #
    # @return an instance of Faraday initialized with all that this gem needs
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