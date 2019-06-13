module Yotpo
  module Oauth
    def validate_token(params, headers = {})
      request = {
          token: params[:utoken],
          app_key: params[:app_key]
      }
      get('/oauth/validate_token', request, headers)
    end

    def get_valid_tokens_per_account(params, headers = {})
      request = {
          token: params[:utoken],
          app_key: params[:app_key],
      }
      get('/oauth/get_valid_tokens_per_account', request, headers)
    end
  end
end


