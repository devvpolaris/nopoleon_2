module Donorbox
  class Webhook < ApplicationRecord
    enum :status, %i[pending processed]

    EVENT_TYPES = %w(
      donation_created
      donation_updated
      campaign_created
      campaign_updated
    ).freeze

    def self.table_name_prefix
      'donorbox_'
    end

    def as_json(*args)
      hash = payload.dup || {}
      hash[:event_name] = event_name
      hash
    end
  end
end
