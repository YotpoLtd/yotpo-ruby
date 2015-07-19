require 'helper'

describe Yotpo::User do

  describe '#create_user' do
    before(:all) do
      @user_info = {
          email: 'newuser4@email.com',
          display_name: 'User Name',
          first_name: 'First Name',
          last_name: 'Last Name',
          website_name: 'My Awesome Web Site',
          password: 'thisispass',
          support_url: 'https://www.google.com/support',
          callback_url: 'https://www.google.com/callback',
          url: 'https://www.google.com'
      }

      VCR.use_cassette('create_user') do
        @response = Yotpo.create_user(@user_info)
      end
    end
    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :app_key }
    it { should respond_to :secret }
    it { should respond_to :token }
    it { should respond_to :id }
  end

  describe '#get_oauth_token' do
    before(:all) do
      oauth_request = {
          app_key: @app_key,
          secret: @secret,
          grant_type: "client_credentials"
      }
      VCR.use_cassette('get_oauth_token') do
        @response = Yotpo.get_oauth_token(oauth_request)
      end
    end
    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :access_token }
    it { should respond_to :token_type }
  end

  describe '#get_login_url' do
    before(:all) do
      request = {
          app_key: @app_key,
          secret: @secret
      }
      VCR.use_cassette('get_login_url') do
        @response = Yotpo.get_login_url(request)
      end
    end
    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :signin_url }

  end
end
