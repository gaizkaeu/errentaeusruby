# frozen_string_literal: true

class Api::V1::OrganizationMembershipsController < ApplicationController
  before_action :authenticate

  def index
    orgs = Api::V1::OrganizationMembership.where(user_id: current_user.id)
                                          .where.not(role: 'deleted')
                                          .joins(:organization)

    render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(orgs, serializer_config)
  end

  private

  def serializer_config
    { params: { include_organization: true } }
  end

  def organization_params
    params.require(:organization_request).permit(:name, :email, :website, :phone, :city, :province)
  end
end
