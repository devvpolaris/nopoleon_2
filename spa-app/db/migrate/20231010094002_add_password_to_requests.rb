class AddPasswordToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :password_digest, :string
  end
end
