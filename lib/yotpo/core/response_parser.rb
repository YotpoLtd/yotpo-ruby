require 'typhoeus/adapters/faraday'
module Yotpo
  class ResponseParser < Faraday::Response::Middleware
    def call(env)
      # "env" contains the request
      @app.call(env).on_complete do
        body = false
        if env[:status] == 200
          body = env[:response].body.response.first[1]
        elsif env[:response] && env[:response].body && env[:response].body.status
          body = env[:response].body.status
        end
        env[:body] = body
      end
    end
  end
end