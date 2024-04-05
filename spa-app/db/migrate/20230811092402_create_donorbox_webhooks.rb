class CreateDonorboxWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :donorbox_webhooks do |t|
      t.string  :event_name
      t.json    :payload
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
