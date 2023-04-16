class Api::V1::Serializers::CalculatorSerializer
  include JSONAPI::Serializer

  set_type :calculator
  set_id :id
  attributes :calculation_topic_id, :classifications, :organization_id, :last_trained_at, :created_at, :updated_at, :correct_rate, :sample_count

  attribute :topic_name do |object|
    object.calculation_topic.name
  end

  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
end
