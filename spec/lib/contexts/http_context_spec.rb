require 'spec_helper'

RSpec.describe MiddleSpec::Contexts::HttpContext do
  context "with relative URI resource" do
    subject { described_class.new(image, resource) }
    let(:resource) { MiddleSpec::Resources::HttpResource.new('/path/to/resource') }

    context 'with http host definition' do
      let(:image) { MiddleSpec::Image.new('example.com', {}) }

      it 'complements host with sever definition' do
        p subject
      end
    end
  end
end
