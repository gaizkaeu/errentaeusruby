class AddBalanceCapturableTodayToOrgStat < ActiveRecord::Migration[7.0]
  def change
    add_column :organization_stats, :balance_capturable_today, :integer, default: 0
  end
end
