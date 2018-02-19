require 'helper'

describe Yotpo::Account do
  describe '#update_account' do
    before(:all) do
      account_data = {
          minisite_website_name: 'Minisite Name',
          minisite_website: 'www.google.com',
          minisite_subdomain: 'google',
          minisite_cname: 'reviews.google.com',
          minisite_subdomain_active: [true, false].sample,
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('update_account') do
        @response = Yotpo.update_account(account_data)
      end
    end
    subject { @response.body.app }
    it { should be_a ::Hashie::Mash }
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
    it { should be_a ::Hashie::Mash }
    it { should respond_to :available }
    it { should respond_to :subdomain }
  end

  describe '#check_lock_state' do
    before(:all) do
      data = {
          app_key: @app_key
      }
      VCR.use_cassette('check_lock_state') do
        @response = Yotpo.check_lock_state(data)
      end
    end
    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :active }
  end
end
