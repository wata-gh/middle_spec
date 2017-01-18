require 'http'

module MiddleSpec
  module Contexts
    class HttpContext < BaseContext
      def response
        return @response if defined?(@response)
        path_resource = find_path_resource
        container = MiddleSpec::Image.containers[@image.name]
        expose = @image.opt['ExposedPorts'].keys.first
        host_port = container.json['NetworkSettings']['Ports'][expose][0]['HostPort']
        headers = { host: resource.uri.host }
        headers.merge!(path_resource.headers || {})
        @response ||= HTTP.headers(headers).request(path_resource.method, "http://localhost:#{host_port}#{path_resource.path}")
      end

      private
      def find_path_resource
        find_resource(MiddleSpec::Resources::PathResource)
      end
    end
  end
end
