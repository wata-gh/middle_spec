require 'http'

module MiddleSpec
  module Contexts
    class MethodContext < BaseContext
      def method
        :get
      end
    end
  end
end
