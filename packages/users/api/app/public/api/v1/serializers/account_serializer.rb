class Api::V1::Serializers::AccountSerializer
  include JSONAPI::Serializer

  set_type :account
  attributes :email, :status
  set_id :id
end
