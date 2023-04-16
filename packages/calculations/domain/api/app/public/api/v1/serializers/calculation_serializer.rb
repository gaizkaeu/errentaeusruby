class Api::V1::Serializers::CalculationSerializer
  include JSONAPI::Serializer

  set_type :calculation
  set_id :id
  attributes :input, :output, :calculator_id, :verified, :train_with, :created_at, :updated_at, :predicted_at, :price_result
end
