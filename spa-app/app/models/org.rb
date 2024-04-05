# frozen_string_literal: true

class Org < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaigns
  has_many :email_templates
  has_many :donations, through: :campaigns
  has_many :donors, through: :donations
  has_many :campaign_requests

  def sum_of_week_donations
    start_of_week = Date.current.beginning_of_week
    end_of_week = Date.current.end_of_week
    week_donations = donations.where(created_at: start_of_week..end_of_week)
    week_donations.sum("CAST(COALESCE(amount, '0') AS FLOAT)")
  end

  def sum_of_month_donations
    start_of_month = Date.current.beginning_of_month
    end_of_month = Date.current.end_of_month
    month_donations = donations.where(created_at: start_of_month..end_of_month)
    month_donations.sum("CAST(COALESCE(amount, '0') AS FLOAT)")
  end

  def sum_of_total_donations
    donations.sum("CAST(COALESCE(amount, '0') AS FLOAT)")
  end
end
