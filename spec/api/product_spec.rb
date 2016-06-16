require 'helper'

describe Yotpo::Product do
  describe '#get_all_bottom_lines' do
    before(:all) do
      get_app_bottom_lines_params = {
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('check_minisite_subdomain') do
        @response = Yotpo.get_all_bottom_lines(get_app_bottom_lines_params)
      end
    end

    subject { @response.body.bottomlines[0] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :domain_key }
    it { should respond_to :product_score }
    it { should respond_to :total_reviews }
  end

  describe '#get_product_bottom_line' do
    before(:all) do
      get_bottom_line_params = {
          product_id: '120915246',
          app_key: @app_key
      }
      VCR.use_cassette('get_product_bottom_line') do
        @response = Yotpo.get_product_bottom_line(get_bottom_line_params)
      end
    end

    subject { @response.body.bottomline }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :average_score }
    it { should respond_to :total_reviews }
  end

  describe '#get_product_url' do
    before(:all) do
      product_url_params = {
          utoken: @utoken,
          reference: 'instagram_comment',
          product_id: '120915246',
          app_key: 'vzStmYud6bHLto5ksn5DoGoA7ghM0kzjMdH2DS5T'
      }
      VCR.use_cassette('get_product_url') do
        @response = Yotpo.get_product_url(product_url_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :url }
  end
end