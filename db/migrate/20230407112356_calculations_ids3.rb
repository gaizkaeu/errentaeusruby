class CalculationsIds3 < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_calculators, id: false do |t|
      t.string :id, null: false, primary_key: true

      t.references :organization, null: false, foreign_key: true, type: :string
      t.string :data

      t.timestamps
    end
  end
end
