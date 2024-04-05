# frozen_string_literal: true

class Campaign < ApplicationRecord
  belongs_to :org
  has_many :donations
  has_many :donors, through: :donations
  has_many :update_campaign_requests

  def raised_amount
    donations
      .pluck(:amount)
      .map(&:to_f)
      .reduce(:+)
  end

  def reviews
    donations.map { |d|
      {
        amount: d[:amount],
        status: d[:status],
        comment: d[:comment],
        questions: d[:questions],
        created_at: d[:created_at].strftime("%d/%m/%Y"),
        donor: "#{d.donor.first_name} #{d.donor.last_name}",
      }
    }
  end
end
