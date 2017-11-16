require 'helper'

describe Yotpo::Image do
  describe '#get_review' do
    before(:all) do
      VCR.use_cassette('get_image') do
        @response = Yotpo.get_image(id: 5)
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
end
