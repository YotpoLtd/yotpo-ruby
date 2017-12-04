require 'helper'

describe Yotpo::Image do
  describe '#get_image' do
    before(:all) do
      VCR.use_cassette('get_image') do
        @response = Yotpo.get_image(id: 5, app_key: @app_key)
      end
    end

    subject { @response.body.image }
    it { should respond_to :id }
    it { should respond_to :image_url }
    it { should respond_to :big_image_url }
    it { should respond_to :image_content_type }
    it { should respond_to :image_width }
    it { should respond_to :image_height }
  end

  describe '#list_images' do
    before(:all) do
      VCR.use_cassette('list_images') do
        @response = Yotpo.list_images(ids: [23,24], app_key: @app_key)
      end
    end

    subject { @response.body.images }
    it { should respond_to :count }

    subject { @response.body.images.first }
    it { should respond_to :id }
    it { should respond_to :image_url }
    it { should respond_to :big_image_url }
    it { should respond_to :image_content_type }
    it { should respond_to :image_width }
    it { should respond_to :image_height }
  end
end
