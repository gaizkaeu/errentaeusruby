class Api::V1::Serializers::CalculatorSerializer
  include JSONAPI::Serializer

  set_type :calculator
  set_id :id
  attributes :calculation_topic_id, :organization_id, :created_at, :updated_at, :questions, :description, :estimated_time, :colors

  attributes :last_trained_at,
             :classifications,
             :calculator_status,
             :sample_count,
             :version,
             :dot_visualization,
             :exposed_variables_formatted,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }

  attribute :topic_name, &:name

  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
end
