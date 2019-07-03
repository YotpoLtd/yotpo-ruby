module Yotpo
  module AccountSocial
    def create_account_social(params, headers = {})
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
      post("/apps/#{params[:app_key]}/account_socials", request, headers)
    end

    def update_account_social(params, headers = {})
      request = {
          utoken: params.delete(:utoken)
      }
      request[:account_social] = params
      put("/apps/#{params.delete(:app_key)}/account_socials/#{params.delete(:id)}", request, headers)
    end

    def get_account_social(params, headers = {})
      request = {
          utoken: params[:utoken]
      }
      get("/apps/#{params[:app_key]}/account_socials", request, headers)
    end
  end
end



