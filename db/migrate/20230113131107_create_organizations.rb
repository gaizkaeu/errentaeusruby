class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name, null: false
      t.string :location, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :website, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
