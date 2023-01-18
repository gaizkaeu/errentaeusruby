class Api::V1::Serializers::ReviewSerializer
  include JSONAPI::Serializer

  set_type :review
  set_id :id
  attributes :rating, :comment, :created_at, :user

  attribute :verified do |record|
    record.tax_income_id.present? || record.lawyer_profile_id.present?
  end

  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
  belongs_to :lawyer_profile, record_type: :lawyer_profile, serializer: Api::V1::Serializers::LawyerProfileSerializer, if: proc { |_record, params| (params[:manage].present? && params[:manage] == true) }
  belongs_to :tax_income, record_type: :tax_income, serializer: Api::V1::Serializers::TaxIncomeSerializer, if: proc { |_record, params| (params[:manage].present? && params[:manage] == true) }
end
