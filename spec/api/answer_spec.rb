require 'helper'

describe Yotpo::Answer do

  describe '#add_shop_owner_answer' do
    before(:all) do
      answer_request = {
        content: 'This is the answer',
        public: true,
        utoken: @utoken,
        question_id: 451
      }
      VCR.use_cassette('add_shop_owner_answer') do
        @response = Yotpo.add_shop_owner_answer(answer_request)
      end
    end

    subject { @response.body.comment }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :id }
    it { should respond_to :commentable_id}
    it { should respond_to :content}
    it { should respond_to :commentable_type}
    it { should respond_to :votes_up}
    it { should respond_to :votes_down}
    it { should respond_to :public}
    it { should respond_to :approved}
    it { should respond_to :created_at}
    it { should respond_to :store_owner_comment}
    it { should respond_to :answerer}
  end
end