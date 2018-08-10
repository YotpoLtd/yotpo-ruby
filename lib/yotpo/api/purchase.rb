module Yotpo
  module Purchase
    def create_new_purchase(params)
      request = {
          utoken: params[:utoken],
          email: params[:email],
          customer_name: params[:customer_name],
          order_date: params[:order_date],
          currency_iso: params[:currency_iso],
          order_id: params[:order_id],
          platform: params[:platform],
          products: params[:products]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/purchases", request)
    end

    def create_new_purchases(params)
      request = {
          utoken: params[:utoken],
          platform: params[:platform],
          orders: params[:orders]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/purchases/mass_create", request)
    end

    def get_purchases(params)
      request = {
          utoken: params[:utoken],
          since_id: params[:since_id],
          since_date: params[:since_date],
          page: params[:page] || 1,
          count: params[:count] || 10
      }
      request.delete_if { |_key, value| value.nil? }
      app_key = params[:app_key]
      get("/apps/#{app_key}/purchases", request)
    end

    #
    # Deletes a Purchase at Yotpo
    #
    # @param params [Hash] the purchase basic information
    # @option params [String] :utoken the login token of the account owner
    # @option params [Array] :orders Array of orders you want to delete (order Hash)
    # @option params [Hash] order Hash { "order_id": "124", "skus": ["101"] }
    # @option params [HashKey] :order_id REQUIRED The order ID
    # @option params [HashKey] :skus OPTIONAL An array of SKUs to delete from the order
    # example orders: [{ "order_id": "123", "skus": ["101"] }, { "order_id": "124" }]
    def delete_purchase(params)
      request = {
        utoken: params[:utoken],
        orders: params[:orders]
      }

      app_key = params[:app_key]
      delete("/apps/#{app_key}/purchases", request)
    end
  end
end
