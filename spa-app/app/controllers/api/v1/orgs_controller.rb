# frozen_string_literal: true

module Api
  module V1
    class OrgsController < BaseController
      before_action :find_org

      def summary
        render json: {
          success: true,
          message: 'success',
          sum_of_week_donations: @org.sum_of_week_donations,
          sum_of_month_donations: @org.sum_of_month_donations,
          sum_of_total_donations: @org.sum_of_total_donations,
          campaigns: @org.campaigns,
          donors: @org.donors,
          donations: @org.donations,
          email_templates: email_templates,
        }
      end

      def donations
        render json: {
          success: true,
          message: 'success',
          donations: @org.donations
        }
      end

      def donors
        render json: {
          success: true,
          message: 'success',
          donations: @org.donors
        }
      end

      def templates
        render json: {
          success: true,
          message: 'success',
          templates: parsed_templates,
        }
      end

      def send_email
        donor_ids = params[:donor_ids]
        subject = params[:subject]
        content_origin = params[:content]
        campaign = Campaign.find_by_shopify_product_id(params[:product_id])
        name = params[:product_title]
        collection_image = params[:collection_image]
        product_image = params[:product_image]

        donor_ids.split(',').each do |id|
          donor = Donor.find(id)
          content = content_origin.dup
            .gsub("[Animal's Name]", name)
            .gsub("[Your Organization's Name]", @org.name)
            .gsub("[Donor's Name]", "#{donor.first_name} #{donor.last_name}")
          NonprofitMailer.send_campaign_email({
            donor: donor,
            subject: subject,
            content: content,
            collection_image: collection_image,
            product_image: product_image
          }).deliver
        end

        render json: {
          success: true,
          message: 'success',
        }
      end

      def upload_donors
        begin
          CSV.foreach(params[:file].path, headers: true) do |row|
            Spa::UploadDonor.new({
              row: row,
              org: @org,
            }).process!
          end

          render json: {
            success: true,
            message: 'success',
          }
        rescue Exceptions::DonorCreationError
        rescue Exceptions::DonationCreationError
          render json: {
            success: false,
            message: 'failed',
          }
        end
      end

      def update_campaign_request
        campaign = Campaign.find_by_shopify_product_id(params[:id])
        # campaign = Campaign.first
        update_campaign_request = campaign.update_campaign_requests.create!(
          description: params[:description],
        )
        update_campaign_request.files.attach(params[:files])

        render json: {
          success: true,
          message: 'success',
        }
      end

      def create_campaign_request
        campaign_request = @org.campaign_requests.create!(
          title: params[:title],
          description: params[:description],
        )
        campaign_request.files.attach(params[:files])

        render json: {
          success: true,
          message: 'success',
        }
      end

      private

      def find_org
        @org = Org.find_by(shopify_collection_id: params[:shopify_collection_id])
      end

      def email_templates
        @org.email_templates.map { |t| { title: t.title, content: t.content.to_trix_html } }
      end
    end
  end
end
