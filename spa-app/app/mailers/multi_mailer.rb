class MultiMailer < ApplicationMailer
  default from: ENV['FROM_EMAIL']

  def self.send_emails(address, content)
    emails = address.split(",")
    emails.each do |email|
      new_request(email,content).deliver_now
    end
  end

  def new_request(email, content)
    @item = content
    mail(to: email, subject: 'To Donors', template_name: 'new_request')
  end
end
