require 'helper'

describe Yotpo::Feature do
  describe '#get_features' do
    before(:all) do
      get_features_params = {
          utoken: @utoken
      }
      VCR.use_cassette('get_features') do
        @response = Yotpo.get_features(get_features_params)
      end
    end

    subject { @response.body.features[0]  }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :name }
    it { should respond_to :description }
    it { should respond_to :owner_type }
  end
end