# frozen_string_literal: true

class TestController < ApplicationController
  def index
    TestNotifierMailer.send_test_email('EMAIL_ADDRESS').deliver
  end
end
