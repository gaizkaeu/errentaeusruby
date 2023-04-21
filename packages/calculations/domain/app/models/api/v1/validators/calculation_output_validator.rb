class Api::V1::Validators::CalculationOutputValidator < ActiveModel::Validator
  def validate(record)
    return if record.output.blank?

    classification = record.output.fetch('classification', nil)
    return if classification.nil?

    record.errors.add(:output, 'classification must be in calculator classifications') unless record.calculator.classifications.key?(classification)
  end
end
