module YotpoApiConnector
  module Purchase
    def update_account(params)
      request = {
          account: {
            minisite_website_name: params[:minisite_website_name],
            minisite_website: params[:minisite_website],
            minisite_subdomain: params[:minisite_subdomain],
            minisite_cname: params[:minisite_cname],
            minisite_subdomain_active: params[:minisite_subdomain_active]
          },
          utoken: params[:utoken]
      }
      app_key = params[:app_key]
      put("/apps/#{app_key}", request)
    end

    def check_minisite_subdomain(params)
      app_key = params[:app_key]
      subdomain = params[:subdomain]
      utoken = params[:utoken]
      get("/apps/#{app_key}/subomain_check/#{subdomain}?utoken=#{utoken}")
    end
  end
end

#def report_spam(abusable_type, abusable_id, abusee_id, abusee_type, description)


