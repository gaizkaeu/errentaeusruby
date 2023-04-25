# frozen_string_literal: true

class Api::V1::OrganizationManage::EmailsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    calls = Api::V1::EmailContact.where(organization: @organization)

    render json: Api::V1::Serializers::EmailSerializer.new(calls, serializer_config)
  end

  def update
    call = Api::V1::EmailContact.find_by(organization: @organization, id: params[:id])

    if call.update(call_update_params)
      render json: Api::V1::Serializers::EmailSerializer.new(call, serializer_config), status: :ok
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  private

  def serializer_config
    { params: { manage: true } }
  end
end
