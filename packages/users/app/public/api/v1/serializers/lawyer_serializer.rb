class Api::V1::Serializers::LawyerSerializer
  include JSONAPI::Serializer

  set_type :lawyer
  set_id :id
  attributes :first_name, :last_name, :email
end
