module YotpoApiConnector
  module Review
    def get_all_products
      get('reviews_me/site_map')
    end
  end
end