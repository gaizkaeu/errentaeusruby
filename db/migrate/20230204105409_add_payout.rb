class AddPayout < ActiveRecord::Migration[7.0]
  def change
    create_table :payouts, id: false do |t|
      t.string :id, primary_key: true
      t.string :organization_id, null: false, index: true, foreign_key: { to_table: :organizations }
      t.integer :amount, null: false
      t.integer :status, null: false
      t.date :date, null: false
      t.datetime :created_at, null: false

      t.index "organization_id, EXTRACT(MONTH FROM date)", unique: true, name: 'index_organization_id_uniqueness_month'
    end
  end
end
