require 'rspec'
require 'pry-byebug'

include MiddleSpec::Helpers::ResourceHelper

RSpec.configure do |config|
  config.include MiddleSpec::Helpers::RSpecHelper

  config.before(:all) do
    @middle_spec_contexts = MiddleSpec::Contexts.from_example(self.class)
  end

  config.before(:each) do
    current_example = RSpec.current_example
    @image, @middle_spec_contexts = MiddleSpec::Contexts.from_example(current_example)
    if @image
      @image.run
      sleep 1
    end
    @middle_spec_contexts.before_each(current_example) if @middle_spec_contexts.respond_to?(:before_each)
  end

  config.after(:each) do
    MiddleSpec::Image.kill_all_containers!
  end
end
