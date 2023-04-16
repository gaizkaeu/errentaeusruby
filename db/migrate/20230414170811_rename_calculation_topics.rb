class RenameCalculationTopics < ActiveRecord::Migration[7.0]
  def change
    rename_column :calculators, :calculation_topics_id, :calculation_topic_id
  end
end
