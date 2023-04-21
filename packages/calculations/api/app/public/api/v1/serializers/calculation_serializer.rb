class Api::V1::Serializers::CalculationSerializer
  include JSONAPI::Serializer

  set_type :calculation
  set_id :id
  attributes :input, :output, :calculator_id, :predicted_at, :price_result, :questions

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
