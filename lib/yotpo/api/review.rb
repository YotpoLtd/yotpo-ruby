module Yotpo
  module Review

    # Creates a new review in yotpo
    #
    # @param attrs [Hash]
    # @return [Twitter::Action::Favorite, Twitter::Action::Follow, Twitter::Action::ListMemberAdded, Twitter::Action::Mention, Twitter::Action::Reply, Twitter::Action::Retweet]
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