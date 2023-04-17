class Api::V1::Serializers::CalculationSerializer
  include JSONAPI::Serializer

  set_type :calculation
  set_id :id
  attributes :input, :output, :calculator_id, :predicted_at, :price_result

  attributes :calculator_id,
             :verified,
             :train_with,
             :created_at,
             :updated_at,
             if: proc { |_record, params|
               params[:manage].present? && params[:manage] == true
             }
end
