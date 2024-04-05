# frozen_string_literal: true

class RequestsController < ApplicationController
  include ActiveStorage::SetCurrent

  def index
    @requests = Request.all
    products = Shopify::Api::Graphql.new().list_products
  end
end
