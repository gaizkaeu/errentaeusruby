class AddReferenceCalculationCallAndEmail < ActiveRecord::Migration[7.0]
  def change
    add_reference :call_contacts, :calculation, null: true, foreign_key: true, type: :string
    add_reference :email_contacts, :calculation, null: true, foreign_key: true, type: :string
  end
end
