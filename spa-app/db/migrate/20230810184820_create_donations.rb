class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.string      :action
      t.string      :amount, default: 0.0
      t.string      :formatted_amount
      t.string      :converted_amount
      t.string      :formatted_converted_amount
      t.string      :converted_net_amount
      t.string      :formatted_converted_net_amount
      t.boolean     :recurring, default: false
      t.boolean     :first_recurring_donation, default: false
      t.string      :amount_refunded
      t.string      :formatted_amount_refunded
      t.string      :stripe_charge_id
      t.integer     :donorbox_id
      t.integer     :status, default: 0 # 0 => paid
      t.string      :donation_type
      t.datetime    :donation_date
      t.boolean     :anonymous_donation
      t.boolean     :gift_aid
      t.string      :designation
      t.boolean     :join_mailing_list
      t.string      :comment
      t.string      :donating_company
      t.string      :currency, default: 'USD'
      t.string      :converted_currency, default: 'USD'
      t.boolean     :offline, default: false
      t.string      :utm_campaign
      t.string      :utm_source
      t.string      :utm_medium
      t.string      :utm_term
      t.string      :utm_content
      t.float       :processing_fee
      t.string      :formatted_processing_fee
      t.boolean     :fee_covered
      t.float       :app_fee
      t.string      :formatted_app_fee
      t.float       :converted_app_fee
      t.string      :formatted_converted_app_fee
      t.text        :questions, array:true, default: []

      t.references  :campaign, index: true
      t.references  :donor, index: true

      t.timestamps
    end
  end
end
