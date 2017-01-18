module MiddleSpec
  module Resources
    class PathResource < BaseResource
      attr_reader :method, :path

      def initialize(method, path, options = {})
        @method = method
        @path = path
        @options = options
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
