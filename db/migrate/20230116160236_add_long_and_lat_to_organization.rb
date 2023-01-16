class AddLongAndLatToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :latitude, :float, null: false, default: 0
    add_column :organizations, :longitude, :float, null: false, default: 0
  end
end
