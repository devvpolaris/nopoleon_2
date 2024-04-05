class AddTitleToCampaignRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :campaign_requests, :title, :string
  end
end
