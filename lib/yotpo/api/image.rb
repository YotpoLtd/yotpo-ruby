module Yotpo
  module Image

    # Gets a specific image in Yotpo
    #
    # @param [Hash] params
    # @option params [String] :id the id of the image
    # @return [::Hashie::Mash] The image with all of it's data
    def get_image(params)
      image_id = params[:id]
      get("/images/#{image_id}")
    end
  end
end