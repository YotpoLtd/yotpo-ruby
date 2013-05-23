require 'helper'

describe Yotpo::AccountPlatform do
  describe '#create_account_platform' do
    before(:all) do
      create_account_platform_request = {
          shop_token: 'asdasdadads',
          shop_domain: 'yahoo.com',
          plan_name: 'test plan',
          platform_type_id: 1,
          deleted: false,
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('create_account_platform') do
        @response = Yotpo.create_account_platform(create_account_platform_request)
      end
    end

    subject { @response.body.account_platform }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :shop_token }
    it { should respond_to :shop_domain }
    it { should respond_to :plan_name }
    it { should respond_to :platform_type }
    it { should respond_to :deleted }
    it { should respond_to :shop_user_name }
  end
end
