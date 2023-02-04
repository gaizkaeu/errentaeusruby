class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false do |t|
      t.string :id, primary_key: true
      t.string :user_id, null: false, index: true, foreign_key: { to_table: :users }
      t.string :organization_id, null: false, index: true, foreign_key: { to_table: :organizations }
      t.string :payment_intent_id, null: false
      t.string :status, null: false
      t.jsonb :metadata, null: false, default: {}

      t.datetime :created_at, null: false
    end
  end
end
