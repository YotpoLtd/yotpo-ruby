require 'helper'

describe Yotpo::Purchase do
  describe '#create_new_purchase' do
    before(:all) do
      create_new_purchase_request = {
          email: Faker::Internet.email,
          customer_name: Faker::Internet.user_name,
          order_id: '123',
          platform: 'shopify',
          products: [
              p1: {
                  url: 'http://example_product_url1.com',
                  name: 'product1',
                  image: 'http://example_product_image_url1.com',
                  description: 'this is the description of a product'
              }
          ],
          utoken: 'asdeuh1di1udifn1309fn09',
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'
      }
      stub_post("/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/purchases").
          with(:headers => {'User-Agent' => 'Faraday v0.8.7', 'Yotpo-Api-Connector' => '0.0.1'}).
          to_return(:status => 200, :body => fixture('new_purchase.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.create_new_purchase(create_new_purchase_request)
    end

    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#create_new_purchases' do
    before(:all) do
      create_new_purchase_request = {
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
          utoken: 'asdeuh1di1udifn1309fn09',
          orders: [
              {
                  email: Faker::Internet.email,
                  customer_name: Faker::Internet.user_name,
                  order_id: '123',
                  platform: 'shopify',
                  products: [
                      p1: {
                          url: 'http://example_product_url1.com',
                          name: 'product1',
                          image: 'http://example_product_image_url1.com',
                          description: 'this is the description of a product'
                      }
                  ]


              }
          ]
      }
      stub_post("/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/purchases/mass_create").
          with(:headers => {'User-Agent' => 'Faraday v0.8.7', 'Yotpo-Api-Connector' => '0.0.1'}).
          to_return(:status => 200, :body => fixture('new_purchase.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.create_new_purchases(create_new_purchase_request)
    end

    subject { @response.body }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :code }
    it { should respond_to :message }
  end

  describe '#get_purchases' do
    before(:all) do
      get_purchases_request = {
          utoken: 'asdeuh1di1udifn1309fn09',
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'
      }
      stub_get('/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/purchases?count=10&page=1&utoken=asdeuh1di1udifn1309fn09').
          with(:headers => {'User-Agent' => 'Faraday v0.8.7', 'Yotpo-Api-Connector' => '0.0.1'}).
          to_return(:status => 200, :body => fixture('get_list_of_purchases.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.get_purchases(get_purchases_request)
    end

    subject { @response.body.purchases[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :user_email }
    it { should respond_to :user_name }
    it { should respond_to :product_sku }
    it { should respond_to :order_id }
    it { should respond_to :product_name }
    it { should respond_to :product_url }
    it { should respond_to :order_date }
    it { should respond_to :product_description }
    it { should respond_to :product_image }
    it { should respond_to :delivery_date }
    it { should respond_to :created_at }
  end
end
