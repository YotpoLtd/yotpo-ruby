module Yotpo
  module AccessToken
    def generate_utoken(params, headers = {})
      request = {
        secret: params[:secret] || Yotpo.secret,
      }
      post("core/v3/stores/#{params[:app_key]}/access_tokens", request, headers)
    end
  end
end
