module YotpoApiConnector
  module Product
    def get_all_bottom_lines(params)
      request = {
          utoken: params[:utoken],
          since_date: params[:since_date],
          since_id: params[:since_id]
      }
      app_key = parama[:app_key]
      get("/apps/#{app_key}/bottom_lines", request)
    end
  end
end