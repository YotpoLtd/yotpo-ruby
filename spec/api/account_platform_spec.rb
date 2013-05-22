require 'helper'

describe Yotpo::AccountPlatform do
  describe '#create_account_platform' do
    before(:all) do
      create_account_platform_request = {
          shop_token: 'asdasdadads',
          shop_domain: Faker::Internet.domain_name,
          plan_name: 'test plan',
          platform_type_id: 1,
          deleted: false,
          utoken: 'asdeuh1di1udifn1309fn09',
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'
      }
      stub_post("/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/account_platform").
          with(:headers => {'User-Agent' => 'Faraday v0.8.7', 'Yotpo-Api-Connector' => '0.0.1'}).
          to_return(:status => 200, :body => fixture('new_account_platform.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.create_account_platform(create_account_platform_request)
    end

    subject { @response.body.account_platform }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :shop_token }
    it { should respond_to :shop_domain }
    it { should respond_to :shop_api_url }
    it { should respond_to :plan_name }
    it { should respond_to :platform_type }
    it { should respond_to :deleted }
    it { should respond_to :shop_user_name }
  end
end
