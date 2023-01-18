class AddOptionalForReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :lawyer_profile_id
    remove_column :reviews, :tax_income_id
    add_column :reviews, :tax_income_id, :string, foreign_key: { to_table: :tax_incomes }, null: true
  end
end
