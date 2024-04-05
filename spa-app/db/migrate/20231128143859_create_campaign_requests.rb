class CreateCampaignRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_requests do |t|
      t.string :description
      t.integer :status, :default => 0
      t.references :org, index: true

      t.timestamps
    end
  end
end
