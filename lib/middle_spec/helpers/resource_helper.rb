module MiddleSpec
  module Helpers
    module ResourceHelper
      def image(name, *args)
        MiddleSpec::Image.images[name]
      end

      def http(*args)
        Resources::HttpResource.new(*args)
      end

      def get(path, *args)
        Resources::PathResource.new(:get, path, *args)
      end

      def post(path, *args)
        Resources::PathResource.new(:post, path, *args)
      end
    end
  end
end
