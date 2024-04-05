class AddEssentialFieldsToOrgs < ActiveRecord::Migration[7.0]
  def change
    add_column :orgs, :name, :string, default: ''
    add_column :orgs, :shopify_collection_id, :bigint
  end
end
