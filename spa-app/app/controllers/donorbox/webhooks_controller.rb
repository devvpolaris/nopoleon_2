# frozen_string_literal: true

module Donorbox
  class WebhooksController < ApplicationController
    before_action :verify_signature_secret
    skip_before_action :verify_authenticity_token

    def create
      # @todo => switch as service & job
      event = Donorbox::Webhook.new(event_name: event_name, payload: payload)
      event.save!

      donor = Donor.find_or_create_by(donor_params)

      unless donor.id
        donor.password = ENV['TEMP_PASSWORD']
        donor.save!
      end

      campaign = Campaign.find_by(donorbox_campaign_id: campaign_params[:id])

      donation = donor.donations.find_or_create_by(
        donation_params.merge(
          donorbox_webhook_id: event.id,
          campaign_id: campaign.id
        )
      )

      head :ok
    end

    private

    def event_name
      webhook_params[:action] == 'new' ? 'donation_created' : 'donation_updated'
    end

    def payload
      JSON.parse(params.to_json)
    end

    def webhook_params
      params.require(:_json).first
    end

    def campaign_params
      webhook_params[:campaign]
    end

    def donor_params
      webhook_params[:donor]
       .permit(
         :email,
         :name,
         :first_name,
         :last_name,
         :donorbox_id,
         :phone,
         :address,
         :address_line_2,
         :city,
         :state,
         :zip_code,
         :country,
         :occupation
       )
       .merge(
         donorbox_id: webhook_params[:donor][:id]
       )
    end

    def donation_params
      webhook_params
       .permit(
         :amount,
         :formatted_amount,
         :converted_amount,
         :formatted_converted_amount,
         :converted_net_amount,
         :formatted_converted_net_amount,
         :recurring,
         :first_recurring_donation,
         :amount_refunded,
         :formatted_amount_refunded,
         :stripe_charge_id,
         :donation_type,
         :donation_date,
         :anonymous_donation,
         :gift_aid,
         :designation,
         :join_mailing_list,
         :comment,
         :donating_company,
         :currency,
         :converted_currency,
         :offline,
         :utm_campaign,
         :utm_source,
         :utm_medium,
         :utm_term,
         :utm_content,
         :processing_fee,
         :formatted_processing_fee,
         :fee_covered,
         :app_fee,
         :formatted_app_fee,
         :converted_app_fee,
         :formatted_converted_app_fee,
       )
    end

    # todo
    def verify_signature_secret
    end
  end
end
