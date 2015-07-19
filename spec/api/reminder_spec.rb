require 'helper'

describe Yotpo::Reminder do
  describe Yotpo::Product do
    describe '#send_test_reminder' do
      before(:all) do
        request ={
            email: 'vlad@yotpo.com',
            utoken: @utoken,
            app_key: @app_key
        }
        VCR.use_cassette('send_test_reminder') do
          @response = Yotpo.send_test_reminder(request)
        end
      end
      subject { @response.body }
      it { should be_a ::Hashie::Rash }
      it { should respond_to :code }
      it { should respond_to :message }
    end
  end
end