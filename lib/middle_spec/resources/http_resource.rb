module MiddleSpec
  module Resources
    class HttpResource < BaseResource
      attr_reader :uri, :options
      def initialize(url, options = {})
        @options = options
        @uri = URI.parse(url)
      end

      def params
        @options[:params]
      end

      def headers
        @options[:headers]
      end
    end
  end
end
