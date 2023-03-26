# frozen_string_literal: true

class Api::V1::OrganizationManage::MembershipsController < Api::V1::OrganizationManage::BaseController
  def index
    memberships = Api::V1::OrganizationMembership.where(organization: @organization).includes(:user)

    render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(memberships)
  end

  def update
    membership = Api::V1::OrganizationMembership.find(params[:id])

    if membership.update(membership_params)
      render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(membership), status: :ok
    else
      render json: membership.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if Api::V1::OrganizationMembership.find(params[:id]).destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:role)
  end
end
