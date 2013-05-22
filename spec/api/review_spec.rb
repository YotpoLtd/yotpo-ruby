require 'helper'

describe Yotpo::Review do

  describe '#create_review' do
    before(:all) do
      anonymous_review = {
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
          sku: Faker::Product.model,
          domain: Faker::Internet.domain_name,
          product_title: Faker::Product.product,
          product_description: Faker::Lorem.paragraph(3),
          product_url: Faker::Internet.http_url,
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          display_name: Faker::Internet.user_name,
          email: Faker::Internet.email,
          review_content: Faker::Lorem.paragraph(3),
          review_title: Faker::Lorem.sentence(5),
          review_score: [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5].sample
      }
      stub_get('/reviews/dynamic_create').with(:query => hash_including({:app_key => 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'})).to_return(:body => fixture('new_review.json'),
                                                                                                                                             :headers => {:content_type => 'application/json; charset=utf-8'})
      @response = Yotpo.create_review(anonymous_review)
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end

  describe '#get_product_reviews' do
    before(:all) do
      get_reviews_params = {
          page: 1,
          count: 5,
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
          product_id: 'A12'
      }
      stub_get("/products/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/A12/reviews?count=5&page=1").
          with(:headers => {'User-Agent'=>'Faraday v0.8.7', 'Yotpo-Api-Connector'=>'0.0.1'}).
          to_return(:status => 200, :body => fixture('get_product_reviews.json'), :headers => {:content_type => 'application/json; charset=utf-8'})
      @response = Yotpo.get_product_reviews(get_reviews_params)
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end
end