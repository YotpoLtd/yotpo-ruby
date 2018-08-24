require 'helper'

describe Yotpo::AccountSocial do
  describe '#create social account' do
    before(:all) do
      account_social_params = {
          utoken: @utoken,
          app_key: @app_key,
          social_network_name: 'INSTAGRAM',
          access_token: 78910,
          social_id: 111213141516,
      }
      VCR.use_cassette('create_account_social') do
        @response = Yotpo.create_account_social(account_social_params)
      end
    end

    subject { @response.body.account_social }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :access_token }
    it { should respond_to :social_id }
  end

  describe '#update social account' do
    before(:all) do
      account_social_params = {
          utoken: @utoken,
          app_key: @app_key,
          access_token: 123,
          secret: 123,
          id: 17
      }
      VCR.use_cassette('update_account_social') do
        @response = Yotpo.update_account_social(account_social_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :account_social }
  end

  describe '#get social account' do
    before(:all) do
      account_social_params = {
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('get_account_social') do
        @response = Yotpo.get_account_social(account_social_params)
      end
    end

    subject { @response.body.account_socials[0] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :access_token }
    it { should respond_to :social_id }
  end
end
