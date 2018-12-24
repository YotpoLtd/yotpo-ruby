module Yotpo
  module Oauth
    def validate_token(params)
      request = {
          token: params[:utoken],
          app_key: params[:app_key]
      }
      get('/oauth/validate_token', request)
    end

    def get_valid_tokens_per_account(params)
      request = {
          token: params[:utoken],
          app_key: params[:app_key],
      }
      get('/oauth/get_valid_tokens_per_account', request)
    end
  end
end


