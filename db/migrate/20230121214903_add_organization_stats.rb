class AddOrganizationStats < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_stats, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :organization_id, null: false, index: true, foreign_key: { to_table: :organizations }
      t.integer :lawyers_active_count, null: false, default: 0
      t.integer :lawyers_active_count_acc, null: false, default: 0
      t.integer :lawyers_inactive_count, null: false, default: 0
      t.integer :lawyers_inactive_count_acc, null: false, default: 0
      t.integer :tax_income_count, null: false, default: 0
      t.integer :tax_income_count_acc, null: false, default: 0
      t.integer :tax_income_finished_count, null: false, default: 0
      t.integer :tax_income_finished_count_acc, null: false, default: 0
      t.integer :tax_income_pending_count, null: false, default: 0
      t.integer :tax_income_pending_count_acc, null: false, default: 0
      t.integer :one_star_count, null: false, default: 0
      t.integer :one_star_count_acc, null: false, default: 0
      t.integer :two_star_count, null: false, default: 0
      t.integer :two_star_count_acc, null: false, default: 0
      t.integer :three_star_count, null: false, default: 0
      t.integer :three_star_count_acc, null: false, default: 0
      t.integer :four_star_count, null: false, default: 0
      t.integer :four_star_count_acc, null: false, default: 0
      t.integer :five_star_count, null: false, default: 0
      t.integer :five_star_count_acc, null: false, default: 0
      t.integer :avg_rating_today, null: false, default: 0
    end
  end
end
