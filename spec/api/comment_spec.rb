require 'helper'

describe Yotpo::Comment do
  describe '#create_comment' do
    before(:all) do
      create_comment_params = {
          utoken: @utoken,
          review_id: 1,
          content: 'Comment content',
          public: true
      }
      VCR.use_cassette('create_comment') do
        @response = Yotpo.create_comment(create_comment_params)
      end
    end

    subject { @response.body.comment }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :commentable_id }
    it { should respond_to :commentable_type }
    it { should respond_to :content }
    it { should respond_to :public }
    it { should respond_to :created_at }
  end
end