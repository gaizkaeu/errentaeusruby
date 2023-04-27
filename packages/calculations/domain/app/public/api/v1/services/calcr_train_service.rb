class Api::V1::Services::CalcrTrainService < ApplicationService
  def call(calculator_id)
    initialize_instance_variables(calculator_id)

    gather_data

    set_training_status_to_training

    predictor = DecisionTree::ID3Tree.new(@calculation_topic.attributes_training, @clean_data, 'error', @calculation_topic.variable_types)
    predictor.train

    @calculator.last_trained_at = Time.zone.now
    @calculator.predictor = predictor
    @calculator.version += 1

    save_dot_visualization

    @calculator.save!

    set_training_status_to_live
  end

  private

  def set_training_status_to_training
    @calculator.update!(calculator_status: 'training')
  end

  def set_training_status_to_live
    @calculator.update!(calculator_status: 'live')
  end

  def save_dot_visualization
    dgp = DotGraphPrinter.new(@calculator.predictor.send(:build_tree))

    dgp.size = ''
    dgp.node_labeler = proc { |n| n.split("\n").first }

    @calculator.dot_visualization = dgp.to_dot_specification
  end

  def initialize_instance_variables(calculator_id)
    @calculator_id = calculator_id
    @calculator = Api::V1::Calculator.find(calculator_id)
    @calculation_topic = @calculator.calculation_topic
  end

  def gather_data
    attributes = @calculation_topic.attributes_training
    @calculator.sample_count = data.count

    @clean_data =
      data.map do |input, output|
        attributes.map do |attribute|
          @calculation_topic.sanitize_training(attribute, input[attribute])
        end << output['classification']
      end
  end

  # rubocop:disable Rails/WhereNotWithMultipleConditions
  def data
    @data ||= Api::V1::Calculation
              .where(calculator_id: @calculator_id, train_with: true)
              .where.not(input: nil, output: nil)
              .where.not(input: {}, output: {})
              .where('output ->> \'classification\' IS NOT NULL')
              .where('output ->> \'classification\' IN (?)', @calculator.classifications.keys)
              .where('input ?& array[:attributes]', attributes: @calculation_topic.attributes_training)
              .distinct(:input)
              .pluck(:input, :output)
  end
  # rubocop:enable Rails/WhereNotWithMultipleConditions
end
