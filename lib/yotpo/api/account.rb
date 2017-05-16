module Yotpo
  module Account

    #
    # Updates account at Yotpo
    #
    # @param params [Hash] the account basic information
    # @option params [String] :minisite_website_name the name to display at the yotpo-minisite
    # @option params [String] :minisite_website the website to link the minisite to
    # @option params [String] :minisite_subdomain the subdomain at yotpo.me to use for this account
    # @option params [String] :minisite_cname the cname that will point to the subdomain.yotpo.com
    # @option params [Boolean Integer] :minisite_subdomain_active enable or disable the feature
    # @option params [String] :utoken the login token of the account owner
    # @option params [String] :app_key the account app key that was created at registration
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

    #
    # Check if the minisite subdomain at yotpo.me is vacant
    #
    # @param params [Hash]
    # @option params [String] :utoken the login token of the account owner
    # @option params [String] :app_key the account app key that was created at registration
    # @option params [String] :subdomain the subdomain to check
    def check_minisite_subdomain(params)
      app_key = params[:app_key]
      subdomain = params[:subdomain]
      utoken = params[:utoken]
      get("/apps/#{app_key}/subomain_check/#{subdomain}?utoken=#{utoken}")
    end

    #
    # Check if the account is locked
    #
    # @param params [Hash]
    # @option params [String] :app_key the account app key that was created at registration
    def check_lock_state(params)
      app_key = params[:app_key]
      get("/apps/#{app_key}/lock_state")
    end
  end
end

