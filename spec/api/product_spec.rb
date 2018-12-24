require 'helper'

describe Yotpo::Product do
  describe '#get_product_information' do
    before(:all) do
      products_params = {
        app_key: 'vzStmYud6bHLto5ksn5DoGoA7ghM0kzjMdH2DS5T',
        domain_keys: ['1', '2']
      }
      VCR.use_cassette('check_products_information') do
        @response = Yotpo.get_products_information(products_params)
      end
    end

    subject { @response.body.products['1'] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :domain_key }
    it { should respond_to :product_link }
    it { should respond_to :name }
  end

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
          app_key: 'vzStmYud6bHLto5ksn5DoGoA7ghM0kzjMdH2DS5T',
          sub_reference: '10'
      }
      VCR.use_cassette('get_product_url') do
        @response = Yotpo.get_product_url(product_url_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
  end

  describe '#products_name_by_sku' do
    before(:all) do
      params = {
        app_key: 'LjRHHPuW4zmcLNyLRAlvEkmGqZ1LULYF62FMIzvM',
        utoken: 'qMwb2i9iJANf7BtXA0MqhKB9opq2sRLRwNYmXaCK',
        domain_keys: ['10']
      }
      VCR.use_cassette('products_name_by_sku') do
        @response = Yotpo.products_name_by_sku(params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to? :products}
  end
end
