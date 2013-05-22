module YotpoApiConnector
  module AccountPlatform
    def create_account_platform(params)
      request ={
           account_platform: {
            shop_token: params[:shop_token],
            shop_domain: params[:shop_domain],
            plan_name: params[:plan_name],
            platform_type_id: params[:platform_type_id],
            deleted: false
          },
          utoken: params[:utoken]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/account_platform", request)
    end
  end
end


