class CreateOrganizationMembership < ActiveRecord::Migration[7.0]
  def change
    create_table(:organization_memberships, id: false) do |t|
      t.string :id, null: false, primary_key: true

      t.references :user, type: :string, foreign_key: { to_table: :users }
      t.references :organization, type: :string, foreign_key: { to_table: :organizations }

      t.string :role, null: false, default: 'member'

      t.index [:user_id, :organization_id], unique: true, name: 'index_organization_memberships_on_user_id_and_organization_id'

      t.timestamps
    end
  end
end
