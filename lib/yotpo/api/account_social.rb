module Yotpo
  module AccountSocial
    def create_account_social(params)
      request = {
          account_social: {
            social_network_name: params[:account_social][:social_network_name],
            access_token: params[:account_social][:access_token],
            social_id: params[:account_social][:social_id],
          },
          utoken: params[:utoken]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/account_socials", request)
    end
  end
end



