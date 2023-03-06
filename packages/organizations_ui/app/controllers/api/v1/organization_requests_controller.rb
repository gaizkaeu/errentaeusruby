# frozen_string_literal: true

module Api
  module V1
    class OrganizationRequestsController < ::ApiBaseController
      before_action :authenticate, except: %i[create]

      def create
        organization = Api::V1::Services::OrgReqCreateService.new.call(organization_params)
        if organization.persisted?
          render json: Api::V1::Serializers::OrganizationRequestSerializer.new(organization), status: :created, location: organization
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      def index
        authorize Api::V1::OrganizationRequest, :index?
        pagy, organizations = Api::V1::Services::OrgReqIndexService.new.call(filtering_params)
        render json: Api::V1::Serializers::OrganizationRequestSerializer.new(organizations, meta: pagy_metadata(pagy))
      end

      def show
        authorize @organization, :show?
        render json: Api::V1::Serializers::OrganizationRequestSerializer.new(@organization)
      end

      private

      def organization_params
        params.require(:organization_request).permit(:name, :email, :website, :phone, :city, :province)
      end

      def set_organization
        @organization = Api::V1::Repositories::OrganizationRequestRepository.find(params[:id])
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::OrganizationRepository::FILTER_KEYS)
      end
    end
  end
end
