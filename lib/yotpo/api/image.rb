module Yotpo
  module Image

    # Gets a specific image in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :app_key the account app key that was created at registration
    # @option params [String] :id the id of the image
    # @return [::Hashie::Mash] The image with all of it's data
    def get_image(params, headers = {})
      image_id = params[:id]
      app_key = params[:app_key]
      get("v1/widget/#{app_key}/images/show/#{image_id}", {}, headers = {})
    end

    # Gets a list of images in Yotpo
    #
    # @param [Hash] params
    # @option params [Array] :ids the ids of the images
    # @return [::Hashie::Mash] The images with all of their data
    def list_images(params, headers = {})
      app_key = params[:app_key]
      request = {
          ids: params[:ids]
      }
      post("v1/widget/#{app_key}/images/list", request, headers)
    end
  end
end