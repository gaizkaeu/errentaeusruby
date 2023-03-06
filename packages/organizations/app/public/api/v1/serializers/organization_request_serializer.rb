class Api::V1::Serializers::OrganizationRequestSerializer
  include JSONAPI::Serializer

  set_type :organization_request
  set_id :id
  attributes :name, :email, :website, :phone, :city, :province
end
