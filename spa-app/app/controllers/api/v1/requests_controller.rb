# frozen_string_literal: true

module Api
  module V1
    class RequestsController < BaseController
      def create
        request = Request.new(request_params)

        if request.valid?
          if request.save
            Spa::RequestProcessJob.perform_later({
              params: request_params,
              record: request,
            })

            head :ok
          else
            render body: request.errors.full_messages.join(', '), status: :bad_request
          end
        else
          # validations failed, handle the errors
          render body: request.errors.full_messages.join(', '), status: :unprocessable_entity
        end
      end

      def animals
        result = Spa::RequestProcessJob.animals_process({
          collection_id: params[:collection_id]
        })
        render json: {
          data: result
        }
      end

      private

      def request_params
        params
          .require(:request)
          .permit(
            :name,
            :email,
            :password,
            :phone,
            :address1,
            :city,
            :state,
            :country,
            :zip,
            :ein,
            :mission,
            :contact,
            :logo
          )
      end
    end
  end
end
