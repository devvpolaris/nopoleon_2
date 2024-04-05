class CreateEmailTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :email_templates do |t|
      t.references :org, index: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
