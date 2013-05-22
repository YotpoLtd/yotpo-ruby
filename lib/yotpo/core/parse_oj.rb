require 'faraday_middleware/response_middleware'

module FaradayMiddleware
  class ParseOj < ResponseMiddleware
    dependency do
      require 'oj' unless defined?(::Oj)
    end

    define_parser do |body|
      ::Oj.load(body, mode: :compat) unless body.strip.empty?
    end
  end
end

Faraday.register_middleware :response, oj: FaradayMiddleware::ParseOj