class Api::V1::Serializers::CallSerializer
  include JSONAPI::Serializer

  set_type :call
  set_id :id
  attributes :first_name, :last_name, :phone_number, :organization_id, :user_id, :created_at
end
