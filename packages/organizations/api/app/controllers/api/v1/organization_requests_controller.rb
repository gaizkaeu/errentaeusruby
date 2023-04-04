# frozen_string_literal: true

class Api::V1::OrganizationRequestsController < ApplicationController
  before_action :authenticate, except: %i[create]

  def create
    organization = Api::V1::OrganizationRequest.create!(organization_params)
    if organization.errors.empty?
      render json: Api::V1::Serializers::OrganizationRequestSerializer.new(organization), status: :created, location: organization
    else
      render json: organization.errors, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization_request).permit(:name, :email, :website, :phone, :city, :province)
  end
end
