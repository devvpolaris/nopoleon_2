# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      rescue_from ::Exception, with: :rescue_exception
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::RoutingError, with: :routing_error

      def undefined_route
        routing_error
      end

      protected

      def allow_access
        true
      end

      def deny_access
        render json: {
          success: false,
          message: 'Access denied'
        }.to_json

        false
      end

      def routing_error(_exception = nil)
        # deliver_exception_notification(exception) if exception

        render json: {
          success: false,
          message: 'Invalid/Undefined API'
        }.to_json
      end

      def record_not_found(_exception)
        # deliver_exception_notification(exception)

        render json: {
          success: false,
          message: 'Record not found'
        }.to_json
      end

      def rescue_exception(exception)
        # deliver_exception_notification(exception)

        render json: {
          success: false,
          message: 'Exception occurred',
          exception: exception.inspect
        }.to_json
      end
    end
  end
end
