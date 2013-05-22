module YotpoApiConnector
  module User

    def create_user(params)
      user = {
          email: params[:email],
          display_name: params[:display_name],
          password: params[:password],
          url: params[:url]
      }
      post('/users', {user: user})
    end

    def get_oauth_token(params)
      request = {
          client_id: params[:client_id],
          client_secret: params[:client_secret],
          grant_type: "client_credentials"
      }

      post('/oauth/token', request)
    end

    def get_login_url(params)
      request = {
          app_key: params[:app_key],
          secret: params[:secret]
      }
      get('/users/b2blogin', request)
    end
  end
end