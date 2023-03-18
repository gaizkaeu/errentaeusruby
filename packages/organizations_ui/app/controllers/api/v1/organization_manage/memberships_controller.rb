# frozen_string_literal: true

class Api::V1::OrganizationManage::MembershipsController < ApiBaseController
  before_action :authenticate

  def index
    memberships = Api::V1::Services::OrgMemIndexService.new.call(current_user, params[:id])

    render json: Api::V1::Serializers::OrganizationMembershipSerializer.new(memberships)
  end
end
