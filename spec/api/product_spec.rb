require 'helper'

describe Yotpo::Product do
  describe '#get_all_bottom_lines' do
    before(:all) do
      get_app_bottom_lines_params = {
          utoken: 'asdeuh1di1udifn1309fn09',
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG'

      }
      stub_get("/apps/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/bottom_lines?utoken=asdeuh1di1udifn1309fn09").
          to_return(:status => 200, :body => fixture('get_all_bottom_lines.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.get_all_bottom_lines(get_app_bottom_lines_params)
    end

    subject { @response.body.bottomlines[0] }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :domain_key }
    it { should respond_to :product_score }
    it { should respond_to :total_reviews }
  end

  describe '#get_product_bottom_line' do
    before(:all) do
      get_bottom_line_params = {
          app_key: 'nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG',
          product_id: 'A12'
      }

      stub_get("/products/nNgGNA54ETOqaXQ7hRZymxqdtwwetJKDVs0v8qGG/A12/bottomline").
          to_return(:status => 200, :body => fixture('get_product_bottom_line.json'), :headers => {:content_type => 'application/json; charset=utf-8'})

      @response = Yotpo.get_product_bottom_line(get_bottom_line_params)
    end

    subject { @response.body.bottomline }
    it { should be_a ::Hashie::Rash }
    it { should respond_to :average_score }
    it { should respond_to :total_reviews }
  end
end