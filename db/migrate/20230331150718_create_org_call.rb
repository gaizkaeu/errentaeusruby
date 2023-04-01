class CreateOrgCall < ActiveRecord::Migration[7.0]
  def change
    create_table :call_contacts, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }, index: true, type: :string

      t.string :first_name
      t.string :last_name
      t.string :phone_number, null: false
      t.string :state, null: false, default: 'pending'
      t.boolean :successful, null: false, default: false
      t.string :notes
      
      t.references :user, foreign_key: { on_delete: :cascade }, index: true, type: :string 

      t.timestamps

    end
    create_table :email_contacts, id: false do |t|
      t.string :id, null: false, primary_key: true

      t.references :organization, null: false, foreign_key: { on_delete: :cascade }, index: true, type: :string

      t.string :state, null: false, default: 'pending'
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.boolean :successful, null: false, default: false
      t.string :notes

      t.references :user, foreign_key: { on_delete: :cascade }, index: true, type: :string 

      t.timestamps
    end
  end
end
