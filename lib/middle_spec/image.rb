require 'docker-api'

module MiddleSpec
  class Image
    class << self
      def define(name, *args)
        options = args.any? ? args.shift : {}
        images[name] = Image.new(name, options)
      end

      def images
        @@images ||= {}
      end

      def containers
        @@containers ||= {}
      end

      def kill_all_containers!
        containers.values.each { |c| c.kill!.remove }
      end
    end

    attr_reader :name, :options

    def initialize(name, options)
      @name, @options = name, options
    end

    def links
      opt = options['opt']
      return [] unless opt
      opt['Links'] || []
    end

    def run_links
      links.each do |name|
        image = MiddleSpec::Image.images[name]
        unless image
          msg = "MiddleSpec::Image #{name} not found."
          MiddleSpec::Image.images.keys.each do |name|
            puts name
          end
          raise NameError, msg
        end
        image.run
      end
    end

    def run
      run_links
      image = Docker::Image.get(options['fromImage'] || options['image_id'])
      unless image
        msg = "docker image #{@name}:#{options['image_id']} not found."
        raise msg
      end
      begin
        Image.containers[name] = image.run(options['cmd'], options['opt'])
      rescue => e
        raise e
      end
    end

    def opt
      options['opt']
    end

    def binds
      opt['Binds']
    end

    def binds=(binds)
      opt['Binds'] = binds
    end
  end
end
