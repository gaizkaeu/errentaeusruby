class Api::V1::Serializers::CallSerializer
  include JSONAPI::Serializer

  set_type :call
  set_id :id
  attributes :first_name, :last_name, :phone_number, :organization_id, :user_id, :created_at

  attribute :calculation,
            if: proc { |_record, params|
                  params[:calculation].present? && params[:calculation] == true
                } do |object|
    Api::V1::Serializers::CalculationSerializer.new(object.calculation).serializable_hash[:data]
  end

  attributes :successful,
             :notes,
             :calculation_id,
             :start_at,
             :call_time,
             :end_at,
             :duration,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }
end
