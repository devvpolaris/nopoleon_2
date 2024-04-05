module Donorbox
  class WebhookSync
    def self.call(webhook)
      new(webhook).call
    end

    # convenience reader methods
    attr_reader :webhook

    # pretty stock initialize
    def initialize(webhook)
      @webhook = webhook
    end

    # actually try to sync the hook
    def call(&block)
      block.call
    end
  end
end
