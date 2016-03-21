require 'helper'

describe Yotpo::Oauth do
  describe '#validate_token' do
    before(:all) do
      validate_token_params = {
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('validate_token') do
        @response = Yotpo.validate_token(validate_token_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :Status }
    it { should respond_to :user_id }
    it { should respond_to :user_has_access_to_account }
    it { should respond_to :application_id }
  end
end