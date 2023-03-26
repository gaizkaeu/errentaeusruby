class Api::V1::Serializers::OrganizationMembershipSerializer
  include JSONAPI::Serializer

  set_type :organization_membership
  set_id :id
  attributes :organization_id, :user_id, :role

  attributes :organization, if: Proc.new { |record, params| params[:include_organization] } do |object|
    Api::V1::Serializers::OrganizationSerializer.new(object.organization)
  end

  attributes :first_name, :last_name
end
