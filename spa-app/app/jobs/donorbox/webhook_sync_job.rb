module Donorbox
  class WebhookSyncJob < ApplicationJob
    queue_as :default

    def perform(args)
      Donorbox::WebhookSync.call(args)
    end
  end
end
