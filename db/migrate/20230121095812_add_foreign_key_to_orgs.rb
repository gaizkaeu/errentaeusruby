class AddForeignKeyToOrgs < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :lawyer_profiles, :organizations, column: :organization_id
  end
end
