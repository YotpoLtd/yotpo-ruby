require 'helper'

describe Yotpo::Reminder do
  describe Yotpo::Product do
    describe '#send_test_reminder' do
      before(:all) do
        request ={
            utoken: 'asdeuh1di1udifn1309fn09',
            app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
            email: 'vlad@yotpo.com'
        }
        stub_post('/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/reminders/send_test_email').with(:body => Oj.dump({utoken: 'asdeuh1di1udifn1309fn09',
                                                                                                                     email: 'vlad@yotpo.com'})).
            to_return(:body => fixture('send_test_email.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
        @response = Yotpo.send_test_reminder(request)
      end
      subject { @response.body }
      it { should be_a ::Hashie::Rash }
      it { should respond_to :status }
    end
  end
end