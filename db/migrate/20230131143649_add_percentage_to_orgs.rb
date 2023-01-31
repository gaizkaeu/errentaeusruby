class AddPercentageToOrgs < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :app_fee, :integer, default: 10
  end
end
