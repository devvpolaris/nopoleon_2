class AddWebhookReferenceToDonations < ActiveRecord::Migration[7.0]
  def change
    add_reference :donations, :donorbox_webhook, index: true
  end
end
