class Api::V1::Serializers::PayoutSerializer
  include JSONAPI::Serializer

  set_type :payout
  set_id :id

  attributes :amount, :date, :status, :organization_id, :metadata, :created_at
end
