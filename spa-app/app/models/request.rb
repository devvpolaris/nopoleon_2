# frozen_string_literal: true

class Request < ApplicationRecord
  has_secure_password
  has_one_attached :logo
  enum :status, %i[pending approved declined cancelled archived]
  validates :name, :email, :ein, presence: true
end
