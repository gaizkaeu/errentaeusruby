class AddMoreAttributesToOrgStat < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_stats, :balance_today, :integer, default: 0
    add_column :organization_stats, :date, :date
    add_index :organization_stats, [:organization_id, :date], unique: true
  end
end
