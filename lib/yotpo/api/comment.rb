module Yotpo
  module Comment
    def create_comment(params)
      request = {
          utoken: params[:utoken],
          comment: {
              content: params[:content],
              public: params[:public]
          }
      }
      post("/reviews/#{params[:review_id]}/comments", request)
    end

    def update_comment_avatar(params)
      request = {
          utoken: params[:utoken],
          comments_avatar_data: params[:comments_avatar_data],
          comments_display_name: params[:comments_display_name]
      }
      put("/apps/#{params[:app_key]}/app_comment_avatar", request)
    end

  end
end


