# frozen_string_literal: true

class Api::V1::OrganizationManage::CallsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    calls = Api::V1::CallContact.where(organization: @organization)

    render json: Api::V1::Serializers::CallSerializer.new(calls, serializer_config)
  end

  def update
    call = Api::V1::CallContact.find_by(organization: @organization, id: params[:id])

    if call.update(call_update_params)
      render json: Api::V1::Serializers::CallSerializer.new(call, serializer_config), status: :ok
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  def start
    call = Api::V1::CallContact.find_by(organization: @organization, id: params[:id])

    if call.start
      render json: Api::V1::Serializers::CallSerializer.new(call, serializer_config), status: :ok
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  def end
    call = Api::V1::CallContact.find_by(organization: @organization, id: params[:id])

    if call.end
      render json: Api::V1::Serializers::CallSerializer.new(call, serializer_config), status: :ok
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  private

  def serializer_config
    { params: { manage: true } }
  end

  def call_update_params
    params.require(:call).permit(:successful, :notes)
  end

  def invitation_update_params
    params.require(:invitation).permit(:role)
  end
end
