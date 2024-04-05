# frozen_string_literal: true

# TestNotifierMailer

class TestNotifierMailer < ApplicationMailer
  default from: ENV['FROM_EMAIL']

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_test_email(email)
    mail(
      to: email,
      subject: 'Hello World!'
    )
  end
end
