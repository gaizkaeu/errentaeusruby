class GooglePlaceId < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :google_place_id, :string
    add_column :organizations, :google_place_verified, :boolean, default: false
  end
end
