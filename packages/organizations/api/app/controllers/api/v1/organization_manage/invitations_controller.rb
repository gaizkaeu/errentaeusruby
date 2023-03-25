# frozen_string_literal: true

class Api::V1::OrganizationManage::InvitationsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    invs = Api::V1::OrganizationInvitation.where(organization: @organization)
                                          .where('created_at > ?', 1.week.ago)
                                          .where(status: 'pending')

    render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invs)
  end

  def create
    invitation = Api::V1::Services::OrgInvCreateService.new.call(current_user, @organization.id, invitation_params)

    if invitation.errors.empty?
      render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitation), status: :created
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  def update
    invitation = Api::V1::OrganizationInvitation.find(params[:id])

    if invitation.update(invitation_update_params)
      render json: Api::V1::Serializers::OrganizationInvitationSerializer.new(invitation), status: :ok
    else
      render json: invitation.errors, status: :unprocessable_entity
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :role)
  end

  def invitation_update_params
    params.require(:invitation).permit(:role)
  end
end
