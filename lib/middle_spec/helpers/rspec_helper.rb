module MiddleSpec
  module Helpers
    module RSpecHelper
      def method_missing(method, *args)
        @middle_spec_contexts.each do |context|
          if context.respond_to?(method)
            return context.public_send(method, *args)
          end
        end

        super
      end
    end
  end
end
