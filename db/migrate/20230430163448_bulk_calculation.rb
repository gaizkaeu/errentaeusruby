class BulkCalculation < ActiveRecord::Migration[7.0]
  def change
    create_table :bulk_calculations, id: false do |t|
      t.string :id, primary_key: true, null: false

      t.jsonb :input, null: false, default: {}

      t.references :user, null: false, foreign_key: true, type: :string
      t.references :calculation_topic, null: false, foreign_key: true, type: :string
    end

    add_reference :calculations, :bulk_calculation, null: true, foreign_key: true, type: :string
  end
end
