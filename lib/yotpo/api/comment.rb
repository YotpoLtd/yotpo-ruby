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
  end
end


