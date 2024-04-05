# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :name,     null: false, default: ''
      t.string :address1, null: false, default: ''
      t.string :city,     null: false, default: ''
      t.string :state,    null: false, default: ''
      t.string :country,  null: false, default: ''
      t.string :zip,      null: false, default: ''

      t.string :ein
      t.string :mission

      t.timestamps
    end
  end
end
