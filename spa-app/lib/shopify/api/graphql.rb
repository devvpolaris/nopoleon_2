module Shopify
  module Api
    class Graphql

      def initialize
      end

      def list_products
        query = <<~QUERY
          query {
            products (first: 3) {
              edges {
                node {
                  id
                  title
                }
              }
            }
          }
        QUERY

        admin_client.query(query: query)
      end

      def create_customer(params)
        query = <<~QUERY
          mutation createCustomer($input: CustomerCreateInput!) {
            customerCreate(input: $input) {
              customer {
                id
                firstName
                email
              }
              customerUserErrors {
                message
                field
                code
              }
            }
          }
        QUERY

        variables = {
          input: {
            email: params[:email],
            firstName: params[:name],
            password: params[:password],
          }
        }

        storefront_client
          .query(query: query, variables: variables)
          .body['data']['customerCreate']
      end

      def update_customer(params)
        query = <<~QUERY
          mutation customerUpdate($input: CustomerInput!) {
            customerUpdate(input: $input) {
              customer {
                id
              }
              userErrors {
                field
                message
              }
            }
          }
        QUERY

        variables = {
          input: params[:input]
        }

        admin_client.query(query: query, variables: variables)
      end

      def get_animals(id)
        query = <<~QUERY
          query collection($id: ID!) {
            collection(id: $id){
              products(first: 50){
                edges {
                  node {
                    id
                    title
                    images(first: 1) {
                      edges {
                        node {
                          src
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        QUERY

        variables = {
          id: id
        }

        admin_client.query(query: query, variables: variables)
      end

      private

      def storefront_client
        ShopifyAPI::Clients::Graphql::Storefront.new(
          shop,
          storefront_access_token,
        )
      end

      def admin_client
        ShopifyAPI::Clients::Graphql::Admin.new(
          session: session
        )
      end

      def session
        ShopifyAPI::Auth::Session.new(
          shop: ENV['SHOPIFY_DOMAIN'],
          access_token: ENV['SHOPIFY_ACCESS_TOKEN']
        )
      end

      def shop
        ENV['SHOPIFY_DOMAIN']
      end

      def storefront_access_token
        ENV['SHOPIFY_STOREFRONT_ACCESS_TOKEN']
      end
    end
  end
end
