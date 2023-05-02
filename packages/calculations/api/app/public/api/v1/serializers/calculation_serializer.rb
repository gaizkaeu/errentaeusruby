class Api::V1::Serializers::CalculationSerializer
  include JSONAPI::Serializer

  set_type :calculation
  set_id :id
  attributes :output, :calculator_id, :predicted_at, :price_result, :questions, :organization_id, :name, :bulk_calculation_id, :created_at

  attribute :input do |object|
    object.input.transform_values(&:to_s)
  end

  attribute :organization do |object|
    Api::V1::Serializers::OrganizationSerializer.new(object.organization).serializable_hash[:data]
  end

  attributes :calculator_id,
             :verified,
             :train_with,
             :created_at,
             :calculator_version,
             :updated_at,
             if: proc { |_record, params|
               params[:manage].present? && params[:manage] == true
             }
  attribute :stale_calculation,
            if: proc { |_record, params|
                  params[:manage].present? && params[:manage] == true
                },
            &:stale_calculation?

  attribute :eligible_for_training,
            if: proc { |_record, params|
                  params[:manage].present? && params[:manage] == true
                },
            &:eligible_for_training?
end
