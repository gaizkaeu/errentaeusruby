class RemovePayouts < ActiveRecord::Migration[7.0]
  def change
    drop_table :payouts
    drop_table :tax_incomes, force: :cascade
    drop_table :transactions
    drop_table :appointments
    drop_table :document_histories
    drop_table :documents
    drop_table :estimations
    drop_table :lawyer_profiles
  end
end
