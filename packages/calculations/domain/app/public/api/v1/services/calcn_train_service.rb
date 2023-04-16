class Api::V1::Services::CalcrTrainService < ApplicationService
  def call(calculator_id)
    initialize_instance_variables(calculator_id)

    gather_data

    predictor = DecisionTree::ID3Tree.new(@calculation_topic.attributes_training, @data, 'error', @calculation_topic.variable_types)
    predictor.train

    @calculator.last_trained_at = Time.zone.now
    @calculator.predictor = predictor

    @calculator.save!
  end

  private

  def initialize_instance_variables(calculator_id)
    @calculator_id = calculator_id
    @calculator = Api::V1::Calculator.find(calculator_id)
    @calculation_topic = @calculator.calculation_topic
  end

  def gather_data
    raw_data = Api::V1::Calculation.where(calculator_id: @calculator_id, train_with: true).pluck(:input, :output)
    attributes = @calculation_topic.attributes_training

    @data =
      raw_data.map do |input, output|
        input.values_at(*attributes) << output['classification']
      end
  end
end
