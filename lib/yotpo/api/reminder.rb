module Yotpo
  module Reminder
    def send_test_reminder(params)
      request ={
          utoken: params[:utoken],
          email: params[:email]
      }
      app_key = params[:app_key]
      post("/apps/#{app_key}/reminders/send_test_email", request)
    end
  end
end


