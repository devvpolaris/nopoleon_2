# frozen_string_literal: true

# NonprofitMailer

class NonprofitMailer < ApplicationMailer
  default from: ENV['FROM_EMAIL']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_request_notification_email(request)
    @request = request

    mail(
      to: request.email,
      subject: 'Welcome to Sponsor a Pet!'
    )
  end

  def send_campaign_email(payload)
    @content = payload[:content]
    @collection_image = payload[:collection_image]
    @product_image = payload[:product_image]

    mail(
      to: payload[:donor].email,
      subject: payload[:subject]
    )
  end
end
