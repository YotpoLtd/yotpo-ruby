module Yotpo
  module AccountSocial
    def create_account_social(params)
      request = {
          account_social: {
            social_network_name: params[:social_network_name],
            access_token: params[:access_token],
            social_id: params[:social_id],
            secret: params[:secret],
            page_token: params[:page_token],
            page_id: params[:page_id],
            message: params[:message],
            social_push_type_id: params[:social_push_type_id],
            invalidated_at: params[:invalidated_at],
          },
          utoken: params[:utoken]
      }
      app_key = params[:app_key] || Yotpo.app_key
      post("/apps/#{params[:app_key]}/account_socials", request)
    end

    def update_account_social(params)
      request = {
          utoken: params.delete(:utoken)
      }
      request[:account_social] = params
      app_key = params[:app_key] || Yotpo.app_key
      params.delete(:app_key)
      put("/apps/#{app_key}/account_socials/#{params.delete(:id)}", request)
    end

    def get_account_social(params)
      request = {
          utoken: params[:utoken]
      }
      app_key = params[:app_key] || Yotpo.app_key
      get("/apps/#{app_key}/account_socials", request)
    end
  end
end



