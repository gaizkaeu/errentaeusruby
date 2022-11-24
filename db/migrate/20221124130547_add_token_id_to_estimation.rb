class AddTokenIdToEstimation < ActiveRecord::Migration[7.0]
  def change
    add_column :estimations, :token, :string
  end
end
