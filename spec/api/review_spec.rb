require 'helper'

describe Yotpo::Review do

  describe '#create_review' do
    before(:all) do
      anonymous_review = {
          product_id: 'D-4771',
          domain: Faker::Internet.domain_name,
          product_title: Faker::Product.product,
          product_description: Faker::Lorem.paragraph(3),
          product_url: Faker::Internet.http_url,
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          user_display_name: Faker::Internet.user_name,
          user_email: Faker::Internet.email,
          review_body: Faker::Lorem.paragraph(3),
          review_title: Faker::Lorem.sentence(5),
          review_score: [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5].sample,
          app_key: @app_key
      }
      VCR.use_cassette('create_review') do
        @response = Yotpo.create_review(anonymous_review)
      end
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
          app_key: @app_key,
          product_id: 'D-4771'
      }
      VCR.use_cassette('get_product_reviews') do
        @response = Yotpo.get_product_reviews(get_reviews_params)
      end
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end
end