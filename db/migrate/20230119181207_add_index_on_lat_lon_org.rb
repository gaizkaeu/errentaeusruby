class AddIndexOnLatLonOrg < ActiveRecord::Migration[7.0]
  def change
    add_index :organizations, [:latitude, :longitude]
  end
end
