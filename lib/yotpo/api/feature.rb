module Yotpo
  module Feature
    def get_features(params)
      request = {
          utoken: params[:utoken]
      }
      get('/features', request)
    end
  end
end


