# frozen_string_literal: true

class UpdateCampaignRequest < ApplicationRecord
  belongs_to :campaign
  enum :status, %i[pending approved declined cancelled archived]
  validates :description, presence: true
  has_many_attached :files

  def file_urls
    if files.attached?
      files.map do |image|
        Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
      end
    else
    end
  end

end
