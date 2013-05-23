require 'helper'

describe Yotpo::Account do
  describe '#update_account' do
    before(:all) do
      account_data = {
          minisite_website_name: Faker::Internet.domain_word,
          minisite_website: Faker::Internet.domain_name,
          minisite_subdomain: Faker::Internet.domain_name,
          minisite_cname: Faker::Internet.domain_name,
          minisite_subdomain_active: [true, false].sample,
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('update_account') do
        @response = Yotpo.update_account(account_data)
      end
    end
    subject { @response.body.app }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :app_key }
  end

  describe '#check_minisite_subdomain' do
    before(:all) do
      sub_domain_data = {
          subdomain: 'shalom1',
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('check_minisite_subdomain') do
        @response = Yotpo.check_minisite_subdomain(sub_domain_data)
      end
    end
    subject { @response.body.subdomain }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :available }
    it { should respond_to :subdomain }


  end
end