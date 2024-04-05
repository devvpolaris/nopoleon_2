class AddNewFieldsToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :phone, :string, null: true, default: ""
    add_column :requests, :contact, :string, null: true, default: ""
  end
end
