class AddAvgRatingToOrgsAndTaxIncomeCount < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :avg_rating, :float, default: 0.0
    add_column :organizations, :tax_income_count, :integer, default: 0
  end
end
