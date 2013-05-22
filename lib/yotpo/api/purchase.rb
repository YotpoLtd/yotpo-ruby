module Yotpo
  module Purchase
    def create_new_purchase(params)
      request = {
          utoken: params[:utoken],
          email: params[:email],
          customer_name: params[:customer_name],
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
          orders: params[:orders]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/purchases/mass_create", request)
    end

    def get_purchases(params)
      request ={
          utoken: params[:utoken],
          since_id: params[:since_id],
          since_date: params[:since_date],
          page: params[:page] || 1,
          count: params[:count] || 10
      }
      request.delete_if{|key, value| value.nil? }
      app_key = params[:app_key]
      get("/apps/#{app_key}/purchases", request)
    end
  end
end