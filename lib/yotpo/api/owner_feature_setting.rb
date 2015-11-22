module Yotpo
  module OwnerFeatureSetting
    def get_feature_settings(params)
      request = {
          utoken: params[:utoken],
          id: params[:feature_id]
      }
      get("features/#{params[:feature_id]}/get_multiple_owners_settings", request)
    end

    def update_feature_settings(params)
      request = {
          utoken: params[:utoken]
      }
      put("features/#{params[:feature_id]}/#{params[:owner_id]}/admin_mass_update", request)
    end
  end
end


