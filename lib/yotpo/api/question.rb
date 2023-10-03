module Yotpo
  module Question

    def question_send_confirmation(params, headers = {})
      request = {
          appkey: params[:app_key],
          sku: params[:product_id],
          product_title: params[:product_title],
          product_url: params[:product_url],
          display_name: params[:user_display_name],
          email: params[:user_email],
          review_content: params[:review_body],
          review_source: params[:review_source],
          product_description: params[:product_description],
          product_image_url: params[:product_image_url],
          demo: params[:demo],
          signature: params[:signature],
          reviewer_type: params[:reviewer_type],
      }
      request.delete_if {|element, value| value.nil? }
      post('questions/send_confirmation_mail', request, headers)
    end

    def question_create_by_token(params, headers = {})
      request = {
          content: params[:content],
          domain: params[:domain],
          product_tags: params[:product_tags],
          product_description: params[:product_description],
          product_image_url: params[:product_image_url],
          product_title: params[:product_name],
          product_url: params[:product_url],
          sku: params[:product_id],
          token: params[:token],
          utm_campaign: params[:utm_campaign],
          utm_medium: params[:utm_medium],
          utm_source: params[:utm_source]
      }
      request.delete_if {|element, value| value.nil? }
      get('questions/create_by_token', request, headers)
    end

  end
end