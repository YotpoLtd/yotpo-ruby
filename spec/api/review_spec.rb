require 'helper'

describe Yotpo::Review do

  describe '#create_review' do
    before(:all) do
      anonymous_review = {
          product_id: 'D-4771',
          domain: 'google.com',
          product_title: 'Product Title',
          product_description: 'Nullam ultrices purus a metus porttitor hendrerit. Vivamus accumsan congue urna a viverra. Nam molestie euismod est, vitae sollicitudin velit scelerisque vel. Quisque feugiat, metus sed tempus malesuada, quam erat volutpat metus, a tempor felis est id purus. Ut nec felis nunc, id cursus magna. Mauris sollicitudin ultrices velit vitae viverra. Nulla faucibus lacus id nisl euismod porta. Curabitur mi magna, tempus tristique commodo sit amet, imperdiet in eros. Proin eros arcu, ornare in lobortis eu, posuere ut risus. Quisque fermentum varius nibh, id aliquet lectus congue quis. In placerat arcu at libero posuere eleifend. Donec lacinia mollis lacus, at aliquam nisi molestie nec. Cras eleifend gravida nulla, vitae mollis eros varius eleifend. Pellentesque elit sem, lacinia eget fringilla vitae, condimentum eu quam. Proin quis orci arcu, ut suscipit arcu.',
          product_url: 'https://www.google.com/?q=pforducturl',
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          user_display_name: 'User Name',
          user_email: 'user@email.com',
          review_body: 'Integer feugiat nunc non leo vehicula bibendum. Nulla at tortor at nulla faucibus suscipit. Curabitur sodales est vel orci lobortis convallis. Vestibulum sit amet tellus neque, ac euismod arcu. Phasellus a nunc ultrices erat condimentum facilisis. Donec a odio in ligula vestibulum lobortis. Mauris posuere, justo tincidunt tincidunt interdum, felis velit venenatis augue, vel rhoncus purus turpis ut magna. Quisque consequat elit vitae enim molestie mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur adipiscing consequat lectus eu pulvinar. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae' ,
          review_title: 'Fusce commodo felis quis turpis fringilla egestas',
          review_score: 4.5,
          app_key: @app_key,
          user_reference: "1234"
      }
      VCR.use_cassette('create_review') do
        @response = Yotpo.create_review(anonymous_review)
      end
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end

  describe '#create_review as trusted vendor' do
    before(:all) do
      review = {
          product_id: 'D-4771',
          domain: 'google.com',
          product_title: 'Product Title',
          product_description: 'Nullam ultrices purus a metus porttitor hendrerit. Vivamus accumsan congue urna a viverra. Nam molestie euismod est, vitae sollicitudin velit scelerisque vel. Quisque feugiat, metus sed tempus malesuada, quam erat volutpat metus, a tempor felis est id purus. Ut nec felis nunc, id cursus magna. Mauris sollicitudin ultrices velit vitae viverra. Nulla faucibus lacus id nisl euismod porta. Curabitur mi magna, tempus tristique commodo sit amet, imperdiet in eros. Proin eros arcu, ornare in lobortis eu, posuere ut risus. Quisque fermentum varius nibh, id aliquet lectus congue quis. In placerat arcu at libero posuere eleifend. Donec lacinia mollis lacus, at aliquam nisi molestie nec. Cras eleifend gravida nulla, vitae mollis eros varius eleifend. Pellentesque elit sem, lacinia eget fringilla vitae, condimentum eu quam. Proin quis orci arcu, ut suscipit arcu.',
          product_url: 'https://www.google.com/?q=pforducturl',
          product_image_url: 'https://www.google.com/images/srpr/logo4w.png',
          user_display_name: 'User Name',
          user_email: 'user@email.com',
          review_body: 'Integer feugiat nunc non leo vehicula bibendum. Nulla at tortor at nulla faucibus suscipit. Curabitur sodales est vel orci lobortis convallis. Vestibulum sit amet tellus neque, ac euismod arcu. Phasellus a nunc ultrices erat condimentum facilisis. Donec a odio in ligula vestibulum lobortis. Mauris posuere, justo tincidunt tincidunt interdum, felis velit venenatis augue, vel rhoncus purus turpis ut magna. Quisque consequat elit vitae enim molestie mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur adipiscing consequat lectus eu pulvinar. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae' ,
          review_title: 'Fusce commodo felis quis turpis fringilla egestas',
          review_score: 4.5,
          app_key: @app_key,
          signature: "e3a30f856453983fc3884ca0c9ef1f31862e6ad25199803dbc192bf2a58f2b31",
          time_stamp: "1426770722",
          reviewer_type: "verified_buyer"
      }
      VCR.use_cassette('create_review_trusted_vendor') do
        @response = Yotpo.create_review(review)
      end
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end

  describe '#get_review' do
    before(:all) do
      VCR.use_cassette('get_review') do
        @response = Yotpo.get_review(id: 22)
      end
    end

    subject { @response.body.review }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end

  describe '#get_product_reviews' do
    before(:all) do
      get_reviews_params = {
          page: 1,
          count: 10,
          app_key: @app_key,
          product_id: '120915246'
      }
      VCR.use_cassette('get_product_reviews') do
        @response = Yotpo.get_product_reviews(get_reviews_params)
      end
    end

    subject { @response.body.reviews[0] }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :user }
    it { should respond_to :content }
    it { should respond_to :title }
  end

  describe '#add_vote_to_review' do
    before(:all) do
      add_vote_params = {
          review_id: 2,
          vote_value: 'up'
      }
      VCR.use_cassette('add_vote_to_review') do
        @response = Yotpo.add_vote_to_review(add_vote_params)
      end
    end

    subject { @response.body.vote }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }

  end

  describe '#get_bottom_line_of_all_site_reviews' do
    before(:all) do
      params = {
        app_key: @app_key
      }
      VCR.use_cassette('get_bottom_line_of_all_site_reviews') do
        @response = Yotpo.get_bottom_line_of_all_site_reviews(params)
      end
    end

    subject { @response.body.bottomline }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :average_score }
    it { should respond_to :total_reviews }
  end
end
