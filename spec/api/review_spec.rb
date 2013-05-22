require 'helper'

describe Yotpo::Review do

  describe '#create_review' do

    before do
      @anonymous_review = {
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
      stub_get('/reviews/dynamic_create').with(:query => hash_including({:app_key => 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'})).to_return(:body => fixture('new_review.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

    end

    it 'should create new review and return a ::Hashie::Rash' do
      response = Yotpo.create_review(@anonymous_review)
      expect(response.body[0]).to be_a ::Hashie::Rash
    end

    it 'should create new review and return a review id' do
      response = Yotpo.create_review(@anonymous_review)
      expect(response.body[0].id).to eq 57707
    end

  end
end