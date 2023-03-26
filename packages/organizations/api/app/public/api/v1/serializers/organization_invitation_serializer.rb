class Api::V1::Serializers::OrganizationInvitationSerializer
  include JSONAPI::Serializer

  set_type :organization_invitation
  set_id :id
  attributes :organization_id, :email, :role, :status, :token
end
