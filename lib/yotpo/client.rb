require 'active_support/notifications'
require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'faraday_middleware'
require 'yotpo/core/response_parser'
require 'yotpo/version'
require 'yotpo/api/account'
require 'yotpo/api/account_platform'
require 'yotpo/api/account_social'
require 'yotpo/api/comment'
require 'yotpo/api/question'
require 'yotpo/api/answer'
require 'yotpo/api/feature'
require 'yotpo/api/oauth'
require 'yotpo/api/image'
require 'yotpo/api/owner_feature'
require 'yotpo/api/owner_feature_setting'
require 'yotpo/api/product'
require 'yotpo/api/purchase'
require 'yotpo/api/reminder'
require 'yotpo/api/review'
require 'yotpo/api/user'

module Yotpo
  class Client
    include Yotpo::Account
    include Yotpo::AccountPlatform
    include Yotpo::AccountSocial
    include Yotpo::Comment
    include Yotpo::Feature
    include Yotpo::Image
    include Yotpo::Oauth
    include Yotpo::OwnerFeature
    include Yotpo::OwnerFeatureSetting
    include Yotpo::Product
    include Yotpo::Reminder
    include Yotpo::Review
    include Yotpo::User
    include Yotpo::Question
    include Yotpo::Answer
    include Yotpo::Purchase


    #
    # Creates a new instance of Yotpo::Client
    #
    # @param url [String] The url to yotpo api (https://api.yotpo.com)
    # @param parallel_requests [Integer String] The maximum parallel request to do (5)
    def initialize(url = 'https://api.yotpo.com', parallel_requests, timeout, user_agent)
      @url = url
      @parallel_requests = parallel_requests
      @timeout = timeout
      @headers = { yotpo_api_connector: 'Ruby'+Yotpo::VERSION }
      @headers.merge!(user_agent: user_agent) if user_agent
    end

    #
    # Does a GET request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    # @param params [Hash] the url params that should be passed in the request
    def get(url, params = {})
      params = params.inject({}) { |memo,(k,v)| memo[k.to_s] = v; memo }
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
      params = convert_hash_keys(params)
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
      params = convert_hash_keys(params)
      preform(url, :put, params: params) do
        return connection.put(url, params)
      end
    end

    #
    # Does a DELETE request to the url with the params
    #
    # @param url [String] the relative path in the Yotpo API
    def delete(url, params)
      params = convert_hash_keys(params)
      preform(url, :delete, params: params) do
        return connection.delete(url, params)
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
      @connection ||= Faraday.new(url: @url, parallel_manager: Typhoeus::Hydra.new(max_concurrency: @parallel_requests), headers: @headers) do |conn|

        conn.options.timeout = @timeout

        conn.use Yotpo::ResponseParser

        # Set the response to be mashified
        conn.response :mashify

        # Setting request and response to use JSON/XML
        conn.request :json
        conn.response :json,
                      content_type: /\bjson$/,
                      parser_options: { symbolize_names: true }

        # Set to use instrumentals to get time logs
        conn.use :instrumentation

        conn.adapter :typhoeus
      end
    end
    private
    def convert_hash_keys(value)
      case value
        when Array
          value.map { |v| convert_hash_keys(v) }
        when Hash
          Hash[value.map { |k, v| [k.to_s, convert_hash_keys(v)] }]
        else
          value
      end
    end
  end
end
