# frozen_string_literal: true

class Donation < ApplicationRecord
  enum :status, %i[paid failed]
  belongs_to :donor
end
