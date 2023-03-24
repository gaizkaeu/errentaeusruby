class Api::V1::Serializers::EstimationSerializer
  include JSONAPI::Serializer

  set_type :estimation

  belongs_to :client, record_type: :user
end
