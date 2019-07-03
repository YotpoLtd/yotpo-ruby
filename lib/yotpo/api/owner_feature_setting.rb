module Yotpo
  module OwnerFeatureSetting
    def get_feature_settings(params, headers = {})
      request = {
          utoken: params[:utoken],
          owner_ids: params[:owner_ids]
      }
      get("features/#{params[:feature_id]}/get_multiple_owners_settings", request, headers)
    end

    def mass_update_feature_settings(params, headers = {})
      request = {
          utoken: params[:utoken],
          settings: params[:settings]
      }
      put("features/#{params[:feature_id]}/#{params[:owner_id]}/admin_mass_update", request, headers)
    end

    def owner_feature_settings(params, headers = {})
      request = {
          utoken: params[:utoken],
      }
      get("apps/#{params[:app_key]}/features/#{params[:feature_id]}/feature_settings", request, headers)
    end

    def update_feature_settings(params, headers = {})
      request = {
          utoken: params[:utoken],
          value: params[:value],
          key: params[:key]
      }
      put("apps/#{params[:app_key]}/features/#{params[:feature_id]}/feature_settings/#{params[:feature_settings_id]}", request, headers)
    end
  end
end


