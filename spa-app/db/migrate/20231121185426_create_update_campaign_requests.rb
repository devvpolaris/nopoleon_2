class CreateUpdateCampaignRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :update_campaign_requests do |t|
      t.string :description
      t.integer :status, :default => 0
      t.references :campaign, index: true

      t.timestamps
    end
  end
end
