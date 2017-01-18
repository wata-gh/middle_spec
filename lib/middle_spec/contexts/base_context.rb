module MiddleSpec
  module Contexts
    class BaseContext
      attr_reader :image
      attr_reader :resource

      def initialize(image, resource, resources)
        @image = image
        @resource = resource
        @resources = resources
      end

      def find_resource(resource_class)
        @resources.find { |resource| resource.is_a?(resource_class) }
      end
    end
  end
end
