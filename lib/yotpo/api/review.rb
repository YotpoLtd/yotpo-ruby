module Yotpo
  module Review

    # Creates a new review in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key the app key of the account for which the review is created
    # @option params [String] :product_id the id of the product
    # @option params [String] :shop_domain the domain of the account
    # @option params [String] :product_title the name of the product for which the review is created
    # @option params [String] :product_description the description of the product for which the review is created
    # @option params [String] :product_url the url of the product for which the review is created
    # @option params [String] :product_image_url the image url of the product for which the review is created
    # @option params [String] :user_display_name the author name
    # @option params [String] :user_email the author email
    # @option params [String] :review_body the review itself
    # @option params [String] :review_title the review title
    # @option params [String Integer] :review_score the rating of the review
    # @option params [String] :utoken the token of the user who wrote the review (if one exists)
    # @return [::Hashie::Mash] The new review with all of it's date
    def create_review(params)
      request = {
          appkey: params[:app_key],
          sku: params[:product_id],
          domain: params[:shop_domain],
          product_title: params[:product_title],
          product_description: params[:product_description],
          product_url: params[:product_url],
          product_image_url: params[:product_image_url],
          display_name: params[:user_display_name],
          email: params[:user_email],
          review_content: params[:review_body],
          review_title: params[:review_title],
          review_score: params[:review_score],
          utoken: params[:utoken]
      }
      request.delete_if {|element, value| value.nil? }
      get('/reviews/dynamic_create', request)
    end


    #
    # Gets reviews of a specific product
    #
    # @param [Hash] params
    # @option params [String] :app_key the app key of the account for which the review is created
    # @option params [String] :product_id the id of the product
    # @option params [Integer] :count the amount of reviews per page
    # @option params [Integer] :page the page number
    # @option params [String] :since_id the id from which to start retrieving reviews
    # @option params [String] :since_date the date from which to start retrieving reviews
    # @option params [String] :utoken the users utoken to get the reviews that are most relevant to that user
    def get_product_reviews(params)
      app_key = params[:app_key]
      sku = params[:product_id]
      request = {
          page: params[:page] || 1,
          count: params[:per_page] || 5,
          since_date: params[:since_date],
          since_id: params[:since_id],
          utoken: params[:utoken]
      }
      request.delete_if{|key,val| val.nil? }
      get("/products/#{app_key}/#{sku}/reviews", request)
    end
  end
end