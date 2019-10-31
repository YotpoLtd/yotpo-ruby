module Yotpo
  module Product
    def get_all_bottom_lines(params, headers = {})
      request = {
          utoken: params[:utoken],
          since_date: params[:since_date],
          since_id: params[:since_id]
      }
      request.delete_if{|key,val| val.nil?}
      app_key = params[:app_key]
      get("/apps/#{app_key}/bottom_lines", request, headers)
    end

    def get_products_information(params, headers = {})
      app_key = params[:app_key]
      request = {
          domain_keys: params[:domain_keys],
          ref_name: params[:ref_name]
      }
      get("/v1/widget/#{app_key}/products/products_information", request, headers)
    end

    #
    # Retrieves the bottom line of a product
    # @param params [Hash]
    # @option params [String] :app_key the accounts app key that was given to it upon registration
    # @option params [String] :product_id the id of the product
    def get_product_bottom_line(params, headers = {})
      app_key = params[:app_key]
      sku = params[:product_id]
      get("/products/#{app_key}/#{sku}/bottomline", {}, headers)
    end

    def get_product_url(params, headers = {})
      app_key = params[:app_key]
      product_id = params[:product_id]
      request = {
          utoken: params[:utoken],
          reference: params[:reference],
          source: params[:source],
          sub_reference: params[:sub_reference]
      }
      request[:product_id] = product_id if product_id
      get("/products/#{app_key}/product_url", request, headers)
    end

    def products_name_by_sku(params, headers = {})
      request = {
        utoken: params[:utoken],
        domain_keys: params[:domain_keys]
      }
      app_key = params[:app_key]
      post("v1/apps/#{app_key}/products_name_by_sku/", request, headers)
    end

    def get_product_matches(params, headers = {})
      request = {
          utoken: params[:utoken],
          source_app_key: params[:source_app_key],
          destination_app_key: params[:destination_app_key],
          domain_keys: params[:domain_keys]
      }
      app_key = params[:app_key]
      post("apps/#{app_key}/products_apps_matches/get_matches/", request, headers)
    end

    # Creates a product(s) in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # @option params [String] :products - A hash of product(s) to create
    # @option params [String] :return_email_address - Include an email address to receive a status report once your request is processed.
    # @option params [String] :result_callback_url - Include a callback URL to receive an asynchronous update once your request is processed.
    # See https://apidocs.yotpo.com/reference#create-mass-products for more info
    def add_products(params, headers = {})
      request = {
          utoken: params[:utoken],
          products: params[:products],
          return_email_address: params[:return_email_address],
          result_callback_url: params[:result_callback_url]
      }

      app_key = params[:app_key]
      post("apps/#{app_key}/products/mass_create", request, headers)
    end

    # Updates a product(s) in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # @option params [String] :products - A hash of product(s) to update
    # @option params [String] :return_email_address - Include an email address to receive a status report once your request is processed.
    # @option params [String] :result_callback_url - Include a callback URL to receive an asynchronous update once your request is processed.
    # See https://apidocs.yotpo.com/reference#update-mass-products for more info
    def update_products(params, headers = {})
      request = {
        utoken: params[:utoken],
        products: params[:products],
        return_email_address: params[:return_email_address],
        result_callback_url: params[:result_callback_url]
      }

      app_key = params[:app_key]
      put("apps/#{app_key}/products/mass_update", request, headers)
    end

    # Gets all products
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # @option params [String] :count - Number of products to return (defaults to 10)
    # @option params [String] :page - Page number to return products for (defaults to 1)
    # See https://apidocs.yotpo.com/reference#retrieve-all-products for more info
    def get_all_products(params, headers = {})
      request = {
          utoken: params[:utoken],
          count: params[:count] || 10,
          page: params[:page] || 1
      }

      app_key = params[:app_key]
      get("apps/#{app_key}/products", request, headers)
    end

    # Add a product group in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # @option params [String] :group_name - The name of the product group
    # See https://apidocs.yotpo.com/reference#create-a-product-group for more info
    def add_product_group(params, headers = {})
      request = {
        utoken: params[:utoken],
        group_name: params[:group_name]
      }

      app_key = params[:app_key]
      post("v1/apps/#{app_key}/products_groups", request, headers)
    end

    # Delete a product group in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # @option params [String] :group_name - The name of the product group
    # See https://apidocs.yotpo.com/reference#delete-a-product-group for more info
    def delete_product_group(params, headers = {})
      request = {
        utoken: params[:utoken],
      }

      app_key = params[:app_key]
      group_name = params[:group_name]
      delete("v1/apps/#{app_key}/products_groups/#{group_name}", request, headers)
    end

    # Gets products group in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key - Your Yotpo account access token
    # See https://apidocs.yotpo.com/reference#retrieve-product-groups-for-account for more info
    def get_product_groups(params, headers = {})
      request = {
        utoken: params[:utoken]
      }

      app_key = params[:app_key]
      get("v1/apps/#{app_key}/products_groups", request, headers)
    end
  end
end