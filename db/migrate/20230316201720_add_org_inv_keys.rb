class AddOrgInvKeys < ActiveRecord::Migration[7.0]
  def change

    create_table :organization_invitations, id: false do |t|
      t.string :id, primary_key: true
      t.string :email, null: false
      t.string :token, null: false
      t.string :status, default: 'pending', null: false
      t.string :role, default: 'lawyer', null: false
      t.references :organization, null: false, foreign_key: true, type: :string

      t.index :token, unique: true
      t.index [:email, :organization_id], unique: true

      t.timestamps
    end

    rename_table :organizations_memberships, :organization_memberships
  end
end
