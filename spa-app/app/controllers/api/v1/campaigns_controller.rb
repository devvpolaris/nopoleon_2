# frozen_string_literal: true

module Api
  module V1
    class CampaignsController < BaseController
      before_action :find_org
      before_action :find_campaign

      def summary
        render json: {
          success: true,
          message: 'success',
          goal_amount: @campaign.goal_amount,
          raised_amount: @campaign.raised_amount,
        }
      end

      def reviews
        render json: {
          success: true,
          message: 'success',
          reviews: @campaign.reviews,
        }
      end

      private

      def find_org
        @org = Org.find_by(shopify_collection_id: params[:shopify_collection_id])
      end

      def find_campaign
        @campaign = Campaign.find_by(shopify_product_id: params[:shopify_product_id])
      end
    end
  end
end
