module Yotpo
  module User

    #
    # Registers a new User with Yotpo
    #
    # @param params [Hash] the user details hash
    # @option params [String] :email the email of the user
    # @option params [String] :display_name the display name of the user
    # @option params [String] :first_name the first name of the user
    # @option params [String] :last_name the last name of the user
    # @option params [String] :website_name the name of the web site that the user owns
    # @option params [String] :domain the domain of the web site that the user owns
    # @option params [String] :url the url of the web site that the user owns
    # @option params [String] :support_url the support url at the users site
    # @option params [String] :callback_url the beginning of the callback url at the users site
    # @return the new account hash
    def create_user(params)
      user = {
          email: params[:email],
          display_name: params[:display_name],
          first_name: params[:first_name],
          last_name: params[:last_name],
          website_name: params[:website_name],
          password: params[:password],
          support_url: params[:support_url],
          callback_url: params[:callback_url],
          url: params[:url]
      }
      post('/users', {user: user})
    end

    #
    # Retrieves an oauth bearer token from Yotpo
    #
    # @param params [Hash] the request details
    # @option params [String] :client_id the app key received at the registration
    # @option params [String] :client_secret app secret received at the registration
    # @return [Hash] that includes access_token and the token_type
    def get_oauth_token(params)
      request = {
          client_id: params[:app_key],
          client_secret: params[:secret],
          grant_type: "client_credentials"
      }

      response = post('/oauth/token', request)
      return response
    end

    #
    # To allow the login into www.yotpo.com using app_key and secret
    # @param params [Hash] the request params
    # @option params [String] :app_key that was received when registered to www.yotpo.com
    # @option params [String] :secret that was received when registered to www.yotpo.com
    def get_login_url(params)
      request = {
          app_key: params[:app_key],
          secret: params[:secret]
      }
      get('/users/b2blogin', request)
    end
  end
end