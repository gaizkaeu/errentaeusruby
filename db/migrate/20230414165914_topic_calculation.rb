class TopicCalculation < ActiveRecord::Migration[7.0]
  def change
    remove_column :calculators, :calculator_type

    create_table :calculation_topics, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name, null: false

      t.jsonb :questions, null: false

      t.timestamps
    end

    add_reference :calculators, :calculation_topics, null: false, foreign_key: true, type: :string
  end
end
