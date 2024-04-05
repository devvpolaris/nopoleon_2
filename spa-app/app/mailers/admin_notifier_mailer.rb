# frozen_string_literal: true

# TestNotifierMailer

class AdminNotifierMailer < ApplicationMailer
  default from: ENV['FROM_EMAIL']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_request_notification_email(request)
    @request = request

    mail(
      to: ENV['ADMIN_EMAIL'],
      subject: 'New Request Received!'
    )
  end
end
