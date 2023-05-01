class Api::V1::CallsController < ApplicationController
  before_action :authenticate

  def create
    call = Api::V1::CallContact.new(call_params)
    call.user = current_user

    if call.save
      render json: Api::V1::Serializers::CallSerializer.new(call), status: :created
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  private

  def call_params
    params.require(:call).permit(:organization_id, :phone_number, :call_time, :calculation_id)
  end
end
