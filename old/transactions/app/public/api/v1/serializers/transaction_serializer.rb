class Api::V1::Serializers::TransactionSerializer
  include JSONAPI::Serializer

  set_type :transaction
  set_id :id

  attributes :amount, :amount_capturable, :status, :payment_intent_id, :user_id, :organization_id, :metadata, :created_at
end
