module Spa
  class RequestProcessJob < ApplicationJob
    queue_as :default

    def perform(args)
      Spa::RequestProcessor.new(args).process!
    end

    def self.animals_process(args)
      Spa::RequestProcessor.new(args).animals!
    end
  end
end
