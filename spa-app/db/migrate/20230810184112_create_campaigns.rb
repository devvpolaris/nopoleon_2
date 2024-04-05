class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string      :name, null: false, default: ''
      t.string      :goal
      t.bigint      :shopify_product_id
      t.bigint      :donorbox_campaign_id
      t.integer     :donorbox_campaign_url

      t.references  :org, index: true

      t.timestamps
    end
  end
end
