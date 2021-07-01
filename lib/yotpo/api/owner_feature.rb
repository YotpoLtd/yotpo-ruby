# frozen_string_literal: true

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

    def user_enable_feature(params)
      request = {
          utoken: params[:utoken],
          feature: {
              user_enabled: params[:user_enabled]
          }
      }
      put("apps/#{params[:app_key]}/features/#{params[:feature_id]}", request)
    end

    def get_owner_features(params)
      request = {
          utoken: params[:utoken]
      }
      get("apps/#{params[:app_key]}/features", request)
    end

    private
    def get_owner_basic_path(owner_type)
      if owner_type == :user
        '/users'
      elsif owner_type == :account
        '/apps'
      elsif owner_type == :organization
        '/organizations'
      else
        raise 'Wrong owner type!'
      end
    end
  end
end


