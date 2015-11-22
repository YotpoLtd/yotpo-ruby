module Yotpo
  module OwnerFeature
    def add_feature(params)
      request = {
          utoken: params[:utoken],
          id: params[:feature_id]
      }
      post("#{get_owner_basic_path(params[:owner_type])}/#{params[:owner_id]}/features", request)
    end

    def remove_feature(params)
      request = {
          utoken: params[:utoken]
      }
      delete("#{get_owner_basic_path(params[:owner_type])}/#{params[:owner_id]}/features/#{params[:feature_id]}", request)
    end

    private

    def get_owner_basic_path(owner_type)
      if owner_type == :user
        '/users'
      elsif owner_type == :account
        '/apps'
      else
        raise 'Wrong owner type!'
      end
    end
  end
end


