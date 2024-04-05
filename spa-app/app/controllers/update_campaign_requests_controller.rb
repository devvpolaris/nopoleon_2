# frozen_string_literal: true

class UpdateCampaignRequestsController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @update_campaign_requests = UpdateCampaignRequest.all
  end
end
