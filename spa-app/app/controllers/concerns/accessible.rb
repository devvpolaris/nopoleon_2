# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    flash.clear
    if current_org
      redirect_to(authenticated_org_root_path) and return
    elsif current_donor
      redirect_to(authenticated_donor_root_path) and return
    else
      redirect_to(authenticated_user_root_path) and return
    end
  end
end
