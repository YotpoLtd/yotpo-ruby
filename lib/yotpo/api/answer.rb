# frozen_string_literal: true

module Yotpo
  module Answer

    def add_shop_owner_answer(params)
      request   = {
        comment: {
            content: params[:content],
            public: params[:public]
        },
        utoken: params[:utoken]
      }
      post("questions/#{params[:question_id]}/answers", request)
    end

  end
end
