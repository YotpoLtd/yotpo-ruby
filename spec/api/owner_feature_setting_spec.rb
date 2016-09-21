require 'helper'

describe Yotpo::OwnerFeatureSetting do

  describe '#get_feature_settings' do
    before(:all) do
      get_settings_params = {
          utoken: @utoken,
          feature_id: 11,
          owner_ids: [300]
      }
      VCR.use_cassette('get_feature_settings') do
        @response = Yotpo.get_feature_settings(get_settings_params)
      end
    end

    subject { @response.body['300'] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :font_size }
  end

  describe '#mass_update_feature_settings' do
    before(:all) do
      feature_update_params = {
          utoken: @utoken,
          settings: { font_size: '12' },
          feature_id: 11,
          owner_id: 7
      }
      VCR.use_cassette('mass_update_feature_settings') do
        @response = Yotpo.mass_update_feature_settings(feature_update_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#owner_feature_settings' do
    before(:all) do
      feature_settings_params = {
          utoken: @utoken,
          feature_id: 11,
          app_key: @app_key
      }
      VCR.use_cassette('owner_feature_settings') do
        @response = Yotpo.owner_feature_settings(feature_settings_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :font_size }
  end

  describe '#update_feature_settings' do
    before(:all) do
      feature_update_params = {
          utoken: @utoken,
          value: 10,
          key: 'font_size',
          app_key: @app_key,
          feature_id: 11,
          feature_settings_id: 38
      }
      VCR.use_cassette('update_feature_settings') do
        @response = Yotpo.update_feature_settings(feature_update_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

end