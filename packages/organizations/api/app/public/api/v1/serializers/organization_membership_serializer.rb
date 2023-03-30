class Api::V1::Serializers::OrganizationMembershipSerializer
  include JSONAPI::Serializer

  set_type :organization_membership
  set_id :id
  attributes :organization_id, :user_id, :role

  attributes :organization, if: proc { |_record, params| params[:include_organization] } do |object|
    Api::V1::Serializers::OrganizationSerializer.new(object.organization, { params: { include_verified_skills: true } })
  end

  attributes :first_name, :last_name
end
