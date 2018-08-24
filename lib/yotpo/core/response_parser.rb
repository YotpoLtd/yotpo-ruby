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
end
