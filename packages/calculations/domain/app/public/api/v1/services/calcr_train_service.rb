class Api::V1::Services::CalcrTrainService < ApplicationService
  def call(calculator_id)
    initialize_instance_variables(calculator_id)

    gather_data

    predictor = DecisionTree::ID3Tree.new(@calculation_topic.attributes_training, @data, 'error', @calculation_topic.variable_types)
    predictor.train

    @calculator.last_trained_at = Time.zone.now
    @calculator.predictor = predictor
    @calculator.version += 1

    save_dot_visualization
    run_test_data

    @calculator.save!
  end

  private

  def save_dot_visualization
    dgp = DotGraphPrinter.new(@calculator.predictor.send(:build_tree))

    dgp.size = ''
    dgp.node_labeler = proc { |n| n.split("\n").first }

    @calculator.dot_visualization = dgp.to_dot_specification
  end

  def run_test_data
    correct = 0

    @test_data.each do |input, output|
      classification = @calculator.predictor.predict(input.values_at(*@calculation_topic.attributes_training))
      if classification == output['classification']
        correct += 1
      end
    end

    @calculator.correct_rate = (correct / @test_data.count.to_f) * 100
  end

  def initialize_instance_variables(calculator_id)
    @calculator_id = calculator_id
    @calculator = Api::V1::Calculator.find(calculator_id)
    @calculation_topic = @calculator.calculation_topic
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def gather_data
    attributes = @calculation_topic.attributes_training

    # rubocop:disable Rails/WhereNotWithMultipleConditions
    raw_data = Api::V1::Calculation
               .where(calculator_id: @calculator_id, train_with: true)
               .where.not(input: nil, output: nil)
               .where.not(input: {}, output: {})
               .where('output ->> \'classification\' IS NOT NULL')
               .where('output ->> \'classification\' IN (?)', @calculator.classifications.keys)
               .where('input ?& array[:attributes]', attributes:)
               .distinct(:input)
               .pluck(:input, :output)

    # rubocop:enable Rails/WhereNotWithMultipleConditions

    raw_data_count = raw_data.count

    train_data_count = (raw_data_count * 0.8).to_i

    @calculator.sample_count = raw_data_count

    train_data = raw_data.sample(train_data_count)
    @test_data = raw_data.reject { |data| train_data.include?(data) }

    @data =
      train_data.map do |input, output|
        input.values_at(*attributes) << output['classification']
      end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
