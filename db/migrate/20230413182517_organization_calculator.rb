class OrganizationCalculator < ActiveRecord::Migration[7.0]
  def change

    drop_table :organization_calculators, if_exists: true

    create_table :calculators, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.references :organization, null: false, foreign_key: true, type: :string
      t.string :calculator_type, null: false
      t.binary :marshalled_predictor, null: false

      t.timestamps
    end

    create_table :calculations, id: false do |t|
      t.string :id, null: false, primary_key: true

      t.references :organization, null: false, foreign_key: true, type: :string
      t.references :calculator, null: false, foreign_key: true, type: :string
      t.references :user, null: false, foreign_key: true, type: :string

      t.jsonb :input, null: false
      t.jsonb :output, null: false

      t.boolean :verified, null: false, default: false
      t.boolean :train_with, null: false, default: false

      t.timestamps
    end
  end
end
