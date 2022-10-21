require 'helper'

describe Yotpo::Product do
  include_context 'endpoints'

  before(:all) do
    @product_payload = {
      external_id: '33',
      name: 'New Product',
      description: 'A description',
      status: 'active',
    }.freeze
  end

  describe '.find_product' do
    before(:all) do
      VCR.use_cassette('find_product') do
        @response = Yotpo.find_product(@base_params.merge(yotpo_product_id: '70000'))
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.product).to be_a ::Hashie::Mash }
  end

  describe '.get_products' do
    before(:all) do
      VCR.use_cassette('get_products') do
        @response = Yotpo.get_products(@base_params)
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.products).to be_a ::Hashie::Array }
  end

  describe '.create_product' do
    before(:all) do
      VCR.use_cassette('create_product') do
        @response = Yotpo.create_product(@base_params.merge(product: @product_payload))
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.dig(:product, :yotpo_id)).to be_an Integer }
  end

  describe '.update_product' do
    before(:all) do
      params = {
        yotpo_product_id: 445581456,
        product: @product_payload.merge(status: 'inactive'),
      }
      VCR.use_cassette('update_product') do
        @response = Yotpo.update_product(@base_params.merge(params))
      end
    end

    subject { @response }
    it { expect(subject.status).to eq 200 }
    it { expect(subject.body).to be_empty }
  end
end
