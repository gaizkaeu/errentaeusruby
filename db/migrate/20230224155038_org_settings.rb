class OrgSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :settings, :jsonb, default: { hireable: true }
    add_column :organizations, :visible, :boolean, default: true
  end
end
