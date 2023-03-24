class Api::V1::Serializers::AccountHistorySerializer
  include JSONAPI::Serializer

  set_type :account_history
  set_id :id
  attributes :message, :at, :metadata

  belongs_to :account, record_type: :account
end
