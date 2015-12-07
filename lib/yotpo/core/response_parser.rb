require 'typhoeus/adapters/faraday'
require 'faraday_middleware/response_middleware'

module Yotpo
  class ResponseParser < Faraday::Response::Middleware
    def parse(body)
      if body.respond_to?(:response) || body.respond_to?(:status)
        body.response || body.status
      else
        body
      end
    end
  end

  #
  # Response middleware that decodes the response body from JSON.
  #
  class ParseOj < FaradayMiddleware::ResponseMiddleware
    dependency do
      require 'oj' unless defined?(::Oj)
    end

    define_parser do |body|
      ::Oj.load(body, mode: :compat) unless body.strip.empty?
    end
  end

  # Request middleware that encodes the body as JSON.
  #
  # Processes only requests with matching Content-type or those without a type.
  # If a request doesn't have a type but has a body, it sets the Content-type
  # to JSON MIME-type.
  #
  # Doesn't try to encode bodies that already are in string form.
  class EncodeOj < Faraday::Middleware
    CONTENT_TYPE = 'Content-Type'.freeze
    MIME_TYPE    = 'application/json'.freeze

    dependency do
      require 'oj' unless defined?(::Oj)
    end

    def call(env)
      match_content_type(env) do |data|
        env[:body] = encode data
      end
      @app.call env
    end

    def encode(data)
      ::Oj.dump data
    end

    def match_content_type(env)
      if process_request?(env)
        env[:request_headers][CONTENT_TYPE] ||= MIME_TYPE
        yield env[:body] unless env[:body].respond_to?(:to_str)
      end
    end

    def process_request?(env)
      type = request_type(env)
      has_body?(env) and (type.empty? or type == MIME_TYPE)
    end

    def has_body?(env)
      body = env[:body] and !(body.respond_to?(:to_str) and body.empty?)
    end

    def request_type(env)
      type = env[:request_headers][CONTENT_TYPE].to_s
      type = type.split(';', 2).first if type.index(';')
      type
    end
  end
end

Faraday::Response.register_middleware oj: Yotpo::ParseOj
Faraday::Request.register_middleware oj: Yotpo::EncodeOj
