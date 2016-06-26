module Yotpo
  module Product
    def get_all_bottom_lines(params)
      request = {
          utoken: params[:utoken],
          since_date: params[:since_date],
          since_id: params[:since_id]
      }
      request.delete_if{|key,val| val.nil?}
      app_key = params[:app_key]
      get("/apps/#{app_key}/bottom_lines", request)
    end

    #
    # Retrieves the bottom line of a product
    # @param params [Hash]
    # @option params [String] :app_key the accounts app key that was given to it upon registration
    # @option params [String] :product_id the id of the product
    def get_product_bottom_line(params)
      app_key = params[:app_key]
      sku = params[:product_id]
      get("/products/#{app_key}/#{sku}/bottomline")
    end

    def get_product_url(params)
      app_key = params[:app_key]
      product_id = params[:product_id]
      request = {
          utoken: params[:utoken],
          reference: params[:reference],
          source: params[:source],
          sub_reference: params[:sub_reference]
      }
      request[:product_id] = product_id if product_id
      get("/products/#{app_key}/product_url", request)
    end
  end
end