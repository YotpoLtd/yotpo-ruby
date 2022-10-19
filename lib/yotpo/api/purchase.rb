module Yotpo
  module Purchase
    def create_new_purchase(params, headers = {})
      request = {
          utoken: params[:utoken],
          email: params[:email],
          customer_name: params[:customer_name],
          order_date: params[:order_date],
          currency_iso: params[:currency_iso],
          order_id: params[:order_id],
          platform: params[:platform],
          coupon_used: params[:coupon_used],
          delivery_type: params[:delivery_type],
          products: params[:products],
          customer: params[:customer],
          custom_properties: params[:custom_properties],
          request_uuid: params[:request_uuid]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/purchases", request, headers)
    end

    def create_new_purchases(params, headers = {})
      request = {
          utoken: params[:utoken],
          platform: params[:platform],
          orders: params[:orders]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/purchases/mass_create", request, headers)
    end

    def get_purchases(params, headers = {})
      request ={
          utoken: params[:utoken],
          since_id: params[:since_id],
          since_date: params[:since_date],
          page: params[:page] || 1,
          count: params[:count] || 10
      }
      request.delete_if{|key, value| value.nil? }
      app_key = params[:app_key]
      get("/apps/#{app_key}/purchases", request, headers)
    end
  end
end