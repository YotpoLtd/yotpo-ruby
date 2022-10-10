require 'helper'

describe Yotpo::ProductVariant do
  subject { @response.body }

  before(:all) do
    @product_variant_payload = {
      external_id: '10',
      name: 'New Product Variant',
    }.freeze
  end

  before(:all) do
    @base_params = {
      app_key: 'foo',
      utoken: 'baz',
      yotpo_product_id: 445581456,
    }.freeze
  end

  describe '.get_product_variants' do
    before(:all) do
      VCR.use_cassette('get_product_variants') do
        @response = Yotpo.get_product_variants(@base_params)
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.variants).to be_a ::Hashie::Array }
  end

  describe '.create_product_variant' do
    before(:all) do
      params = @base_params.merge(variant: @product_variant_payload)
      VCR.use_cassette('create_product_variant') do
        @response = Yotpo.create_product_variant(params)
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.dig(:variant, :yotpo_id)).to be_an Integer }
  end

  describe '.update_product_variant' do
    before(:all) do
      product_variant_payload = @product_variant_payload.merge(description: 'An updated description')
      params = @base_params.merge(yotpo_variant_id: 577594830, variant: product_variant_payload)
      VCR.use_cassette('update_product_variant') do
        @response = Yotpo.update_product_variant(params)
      end
    end

    subject { @response }
    it { expect(subject.status).to eq 200 }
    it { expect(subject.body).to be_empty }
  end
end
