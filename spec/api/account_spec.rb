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
          utoken: '12ei1rr1i3ufn23itfoijver903',
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'
      }
      stub_put('/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG').
          to_return(:status => 200, :body => fixture('update_account.json'), :headers => {})
      @response = Yotpo.update_account(account_data)
    end
    subject { @response.body.app }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :app_key }
  end

  describe '#check_minisite_subdomain' do
    before(:all) do
      sub_domain_data = {
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
          subdomain: 'shalom1',
          utoken: '12ei1rr1i3ufn23itfoijver903'
      }
      stub_get('/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/subomain_check/shalom1?utoken=12ei1rr1i3ufn23itfoijver903').
          to_return(:status => 200, :body => fixture('check_subdomain.json'), :headers => {})

      @response = Yotpo.check_minisite_subdomain(sub_domain_data)
    end
    subject { @response.body.subdomain }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :available }
    it { should respond_to :subdomain }


  end
end