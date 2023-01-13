class Api::V1::Serializers::OrganizationSerializer
  include JSONAPI::Serializer

  set_type :organization
  set_id :id
  attributes :name, :description, :website, :email, :phone, :location

  belongs_to :owner, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
end
