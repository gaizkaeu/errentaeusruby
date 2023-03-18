class Api::V1::Serializers::OrganizationMembershipSerializer
  include JSONAPI::Serializer

  set_type :organization_membership
  set_id :id
  attributes :organization_id, :user_id, :role

  attributes :first_name, :last_name
end
