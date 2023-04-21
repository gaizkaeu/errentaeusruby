class AddValidationFileToCalculationTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :calculation_topics, :validation_file, :string
  end
end
