class AddAccountHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :account_histories do |t|
      t.datetime :time
      t.integer :action
      t.string :ip
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
