class Api::V1::Serializers::TaxIncomeSerializer
  include JSONAPI::Serializer

  set_type :tax_income
  attributes :year, :observations, :created_at, :updated_at, :state, :price, :captured

  attribute :client do |object|
    {
      id: object.client_id,
      first_name: object.client.first_name,
      last_name: object.client.last_name
    }
  end

  attribute :lawyer do |object|
    {
      id: object.lawyer_id
    }
  end

  attribute :organization do |object|
    {
      id: object.organization_id,
      name: object.organization.name
    }
  end

  belongs_to :client, record_type: :user, serializer: Api::V1::Serializers::UserSerializer
  belongs_to :lawyer, record_type: :lawyer_profile, serializer: Api::V1::Serializers::LawyerProfileSerializer
  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
  belongs_to :appointment, record_type: :appointment
  belongs_to :estimation, record_type: :estimation
end
