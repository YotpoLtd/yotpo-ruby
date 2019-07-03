module Yotpo
  module Feature
    def get_features(params, headers = {})
      request = {
          utoken: params[:utoken]
      }
      get('/features', request, headers)
    end
  end
end


