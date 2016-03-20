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

  describe '#get_owner_features' do
    before(:all) do
      get_owner_features_params = {
          utoken: @utoken,
          app_key: @app_key
      }
     VCR.use_cassette('get_owner_features') do
        @response = Yotpo.get_owner_features(get_owner_features_params)
     end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#user_enable_feature' do
    before(:all) do
      user_enable_feature_params = {
          utoken: @utoken,
          app_key: @app_key,
          feature_id: 5,
          user_enabled: true
      }
      VCR.use_cassette('user_enable_feature') do
        @response = Yotpo.user_enable_feature(user_enable_feature_params)
      end
    end

    subject { @response.body.feature }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :name }
    it { should respond_to :description }
  end

end