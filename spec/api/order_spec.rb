require 'helper'

describe Yotpo::Order do
  include_context 'endpoints'

  before(:all) do
    @order_payload = {
      external_id: '1000',
      order_date: '2022-10-21T15:49:47Z',
      line_items: [{ external_product_id: '300000', quantity: 1 }],
      customer: { external_id: '2000' },
    }.freeze
  end

  describe '.find_order' do
    before(:all) do
      VCR.use_cassette('find_order') do
        @response = Yotpo.find_order(@base_params.merge(yotpo_order_id: '70000'))
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.order).to be_a ::Hashie::Mash }
  end

  describe '.get_orders' do
    before(:all) do
      VCR.use_cassette('get_orders') do
        @response = Yotpo.get_orders(@base_params)
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.orders).to be_a ::Hashie::Array }
  end

  describe '.create_order' do
    before(:all) do
      params = @base_params.merge(order: @order_payload)
      VCR.use_cassette('create_order') do
        @response = Yotpo.create_order(params)
      end
    end

    it { is_expected.to be_a ::Hashie::Mash }
    it { expect(subject.dig(:order, :yotpo_id)).to be_an Integer }
  end

  describe '.update_order' do
    before(:all) do
      order_payload = @order_payload.merge(order_name: 'An edited order')
      params = @base_params.merge(yotpo_order_id: '70000', order: order_payload)
      VCR.use_cassette('update_order') do
        @response = Yotpo.update_order(params)
      end
    end

    subject { @response }
    it { expect(subject.status).to eq 200 }
    it { expect(subject.body).to be_empty }
  end
end
