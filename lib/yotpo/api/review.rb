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
    # @return [::Hashie::Rash] The new review with all of it's date
    def create_review(params)
      request = {
          app_key: params[:app_key],
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
  end
end