module Spa
  class RequestProcessor
    def initialize(payload)
      @params = payload[:params]
      @record = payload[:record]
      @collection_id = payload[:collection_id]
    end

    def process!
      setup!
      notify!
    end

    def animals!
      id = "gid://shopify/Collection/" + @collection_id
      result = graphql.get_animals(id)
    end

    private

    def setup!
      # create customer with email, name and password
      result = graphql.create_customer(@params)

      if result.present?
        # update created customer with default metafield
        input = {
          id: result['customer']['id'],
          metafields: customer_role_metafields,
        }

        graphql.update_customer({ input: input })
      end
    end

    def notify!
      AdminNotifierMailer.send_request_notification_email(@record).deliver
      NonprofitMailer.send_request_notification_email(@record).deliver
    end

    def graphql
      Shopify::Api::Graphql.new
    end

    def customer_role_metafields
      [
        {
          namespace: 'custom',
          key: 'role',
          type: 'single_line_text_field',
          value: 'admin'
        }
      ]
    end
  end
end
