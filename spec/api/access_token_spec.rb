require 'helper'

describe Yotpo::AccessToken do
  describe '#generate_utoken' do
    before(:all) do
      params = { app_key: 'foo', secret: 'bar' }
      VCR.use_cassette('generate_utoken') do
        @response = Yotpo.generate_utoken(params)
      end
    end

    subject { @response.body }
    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.access_token).to eq 's0met0ken' }
  end
end
