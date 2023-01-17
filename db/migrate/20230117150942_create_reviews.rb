class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :tax_income_id, null: false, index: true, foreign_key: { to_table: :tax_incomes }, index: true
      t.string :lawyer_profile_id, null: false, index: true, foreign_key: { to_table: :lawyer_profiles }, index: true
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
