require 'helper'

describe Yotpo::OwnerFeature do
  describe '#add_feature' do
    before(:all) do
      add_feature_params = {
          owner_type: :account,
          owner_id: @app_key,
          feature_id: 1,
          utoken: @utoken
      }
      VCR.use_cassette('add_features') do
        @response = Yotpo.add_feature(add_feature_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#remove_feature' do
    before(:all) do
      remove_feature_params = {
          owner_type: :account,
          owner_id: @app_key,
          feature_id: 1,
          utoken: @utoken
      }
      VCR.use_cassette('remove_feature') do
        @response = Yotpo.remove_feature(remove_feature_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end
end