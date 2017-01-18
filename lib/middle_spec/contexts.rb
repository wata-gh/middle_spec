require 'middle_spec/contexts/base_context'
require 'middle_spec/contexts/http_context'
require 'middle_spec/contexts/path_context'

module MiddleSpec
  module Contexts
    class << self
      def from_example(example)
        eg = example.example_group
        image_resource = find_described_image(eg)
        resources = find_described(Resources::BaseResource, eg, [])
        return [] unless image_resource || resources.empty?

        if image_resource && resources.empty?
          return []
        end

        contexts = resources.map do |resource|
          resource.context_class.new(image_resource, resource, resources)
        end

        [image_resource, contexts]
      end

      def find_described_image(example_group)
        arg = example_group.metadata[:description_args].first
        if arg.is_a?(Image)
          arg
        else
          eg = example_group.parent_groups[1]
          find_described_image(eg) if eg
        end
      end

      def find_described(resource_class, example_group, resources)
        arg = example_group.metadata[:description_args].first
        if arg.is_a?(resource_class)
          resources << arg
        end

        eg = example_group.parent_groups[1]
        find_described(resource_class, example_group.parent_groups[1], resources) if eg

        resources
      end
    end
  end
end
