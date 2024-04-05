module Shopify
  module Api
    class Admin

      def initialize
      end

      def list_hooks
        url = api_url('list', 'webhooks')
        get(url)
      end

      private

      def base_url
        "https://#{ENV['SHOPIFY_DOMAIN']}/admin/api/#{ENV['SHOPIFY_API_VERSION']}"
      end

      def api_url(type, scope, id = false, sub_scope = false)
        case type
        when 'list', 'post'
          sub_scope ? "#{base_url}/#{scope}/#{id}/#{sub_scope}.json" : "#{base_url}/#{scope}.json"
        when 'get', 'put', 'delete'
          sub_scope ? "#{base_url}/#{scope}/#{id}/#{sub_scope}.json" : "#{base_url}/#{scope}/#{id}.json"
        end
      end

      def get(url)
        begin
          response = RestClient.get url, {
            'X-Shopify-Access-Token' => ENV['SHOPIFY_ACCESS_TOKEN'],
            'Content-Type' => 'application/json'
          }

          return JSON.parse(response)
        rescue RestClient::ExceptionWithResponse => e
          http_body = JSON.parse(e.http_body)
          meaningful_error_message = http_body['message'].nil? ? e.message : http_body['message']
        end
      end

      def post(url, body)
        begin
          response = RestClient.post url, body.to_json, {
            'X-Shopify-Access-Token' => ENV['SHOPIFY_ACCESS_TOKEN'],
            'Content-Type' => 'application/json'
          }

          return JSON.parse(response)
        rescue RestClient::ExceptionWithResponse => e
          http_body = JSON.parse(e.http_body)
          meaningful_error_message = http_body['message'].nil? ? e.message : http_body['message']
        end
      end

      def put(url, body)
        begin
          response = RestClient.put url, body.to_json, {
            'X-Shopify-Access-Token' => ENV['SHOPIFY_ACCESS_TOKEN'],
            'Content-Type' => 'application/json'
          }

          return JSON.parse(response)
        rescue RestClient::ExceptionWithResponse => e
          http_body = JSON.parse(e.http_body)
          meaningful_error_message = http_body['message'].nil? ? e.message : http_body['message']
        end
      end

      def delete(url)
        begin
          response = RestClient.delete url, {
            'X-Shopify-Access-Token' => ENV['SHOPIFY_ACCESS_TOKEN'],
            'Content-Type' => 'application/json'
          }

          return JSON.parse(response)
        rescue RestClient::ExceptionWithResponse => e
          http_body = JSON.parse(e.http_body)
          meaningful_error_message = http_body['message'].nil? ? e.message : http_body['message']
        end
      end
    end
  end
end
