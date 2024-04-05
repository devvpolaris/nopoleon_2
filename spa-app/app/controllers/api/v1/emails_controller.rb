# frozen_string_literal: true

module Api
  module V1
    class EmailsController < BaseController
      def send_email
        address = params[:address]
        content = params[:content]
        sender = params[:sender]
        if MultiMailer.send_emails(address, content)
          render json: {
            success: true,
            message: "success"
          }
        end
      end
    end
  end
end
