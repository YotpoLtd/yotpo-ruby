require 'helper'

describe Yotpo::User do

  describe '#create_user' do
    before(:all) do
      @user_info = {
          email: Faker::Internet.email,
          display_name: Faker::Internet.user_name,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          website_name: Faker::Internet.domain_name,
          password: Faker::Lorem.words(3).join(' '),
          support_url: Faker::Internet.http_url,
          callback_url: Faker::Internet.http_url,
          url: Faker::Internet.http_url
      }
      stub_post('/users').with(:body => Oj.dump({:user => @user_info})).to_return(:body => fixture('new_user.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
      @response = Yotpo.create_user(@user_info)
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
          app_key: 'a3lmMnC3u4SNmz0ZcHf3lODeIYM9LEQwtTWXRdDP',
          secret: 'NumuadvlCGOTwnCCvY5BRAhGib1LTCFptYxfvebm',
          grant_type: "client_credentials"
      }
      stub_request(:post, "https://api.yotpo.com/oauth/token").
          with(:body => "{\":client_id\":\"a3lmMnC3u4SNmz0ZcHf3lODeIYM9LEQwtTWXRdDP\",\":client_secret\":\"NumuadvlCGOTwnCCvY5BRAhGib1LTCFptYxfvebm\",\":grant_type\":\"client_credentials\"}").
          to_return(:status => 200, :body => fixture('bearer_token.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
      @response = Yotpo.get_oauth_token(oauth_request)
    end
    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :access_token }
    it { should respond_to :token_type }
  end

  describe '#get_login_url' do
    before(:all) do
      request = {
          app_key: 'a3lmMnC3u4SNmz0ZcHf3lODeIYM9LEQwtTWXRdDP',
          secret: 'NumuadvlCGOTwnCCvY5BRAhGib1LTCFptYxfvebm'
      }
      stub_get('/users/b2blogin').with(:query => hash_including(request)).to_return(:body => fixture('get_login_url.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
      @response = Yotpo.get_login_url(request)
    end
    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :signin_url }

  end
end