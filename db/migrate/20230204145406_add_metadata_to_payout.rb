class AddMetadataToPayout < ActiveRecord::Migration[7.0]
  def change
    add_column :payouts, :metadata, :jsonb, null: false, default: {}
  end
end
