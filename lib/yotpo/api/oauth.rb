module Yotpo
  module Oauth
    def validate_token(params)
      request = {
          token: params[:utoken],
          app_key: params[:app_key]
      }
      get('/oauth/validate_token', request)
    end
  end
end


