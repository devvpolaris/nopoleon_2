# frozen_string_literal: true

class CampaignRequestsController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @campaign_requests = CampaignRequest.all
  end
end
