class RemoveOrgStat < ActiveRecord::Migration[7.0]
  def change
    drop_table :organization_stats
  end
end
