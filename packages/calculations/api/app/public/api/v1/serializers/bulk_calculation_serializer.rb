class Api::V1::Serializers::BulkCalculationSerializer
  include JSONAPI::Serializer

  set_type :bulk_calculation
  set_id :id

  attribute :input do |object|
    object.input.transform_values(&:to_s)
  end
end
