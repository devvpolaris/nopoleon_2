class AddEssentialFieldsToDonors < ActiveRecord::Migration[7.0]
  def change
    add_column :donors, :name, :string, default: ''
    add_column :donors, :first_name, :string, default: ''
    add_column :donors, :last_name, :string, default: ''
    add_column :donors, :phone, :string, default: ''
    add_column :donors, :address, :string, default: ''
    add_column :donors, :address_line_2, :string, default: ''
    add_column :donors, :city, :string, default: ''
    add_column :donors, :state, :string, default: ''
    add_column :donors, :zip_code, :string, default: ''
    add_column :donors, :country, :string, default: ''
    add_column :donors, :occupation, :string, default: ''
    add_column :donors, :donorbox_id, :integer
  end
end
