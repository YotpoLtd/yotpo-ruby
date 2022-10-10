module Yotpo
  module Requests
    class Endpoint
      attr_reader :uri, :request_method, :options

      def initialize(uri, **options)
        @uri = uri
        @options = options
        @request_method = options.delete(:method) || :get
      end

      def request(client, params, **headers)
        Request.new(self, params, headers).send_with(client)
      end

      def public?
        options.key?(:public) ? !!options[:public] : false
      end
    end

    class Request
      attr_reader :endpoint, :uri, :params, :headers

      def initialize(endpoint, params, headers)
        @endpoint = endpoint
        @params = Hashie::Mash.new(params)
        @headers = headers.dup
        @headers['X-Yotpo-Token'] = @params.delete(:utoken) || Yotpo.utoken unless endpoint.public?
        @app_key = @params.delete(:app_key) || Yotpo.app_key
        @uri = resolve_uri(endpoint.uri)
      end

      def send_with(client)
        client.public_send(endpoint.request_method, uri, params, headers)
      end

      private

      attr_reader :app_key

      def resolve_uri(uri_base)
        uri_base.gsub(/{(\w+)}/) { |args| uri_replacement_for($1) }
      end

      def uri_replacement_for(field)
        if field == 'app_key'
          @app_key
        elsif params.key?(field)
          params.delete(field)
        else
          raise MissingParameterError.new("Missing required parameter #{field}")
        end
      end
    end

    def define_endpoint(name, uri, **options)
      endpoint = Endpoint.new(uri, **options)
      define_method name do |params, **headers|
        endpoint.request(self, params, **headers)
      end
      self
    end
  end
end
