module Yotpo
  module Answer

    def add_shop_owner_answer(params, headers = {})
      request   = {
        comment: {
            content: params[:content],
            public: params[:public]
        },
        utoken: params[:utoken]
      }
      post("questions/#{params[:question_id]}/answers", request, headers)
    end

  end
end
