class Api::V1::Serializers::ReviewSerializer
  include JSONAPI::Serializer

  set_type :review
  set_id :id
  attributes :rating, :comment, :created_at
end
