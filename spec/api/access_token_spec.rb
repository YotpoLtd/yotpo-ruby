require 'helper'

describe Yotpo::AccessToken do
  include_context 'endpoints'

  describe '#generate_utoken' do
    before(:all) do
      VCR.use_cassette('generate_utoken') do
        @response = Yotpo.generate_utoken(@base_params)
      end
    end

    subject { @response.body }
    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.access_token).to eq 's0met0ken' }
  end
end
