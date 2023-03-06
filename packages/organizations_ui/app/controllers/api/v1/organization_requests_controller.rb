# frozen_string_literal: true

module Api
  module V1
    class OrganizationRequestsController < ::ApiBaseController
      before_action :authenticate, except: %i[create]

      def index
        organizations =
          Api::V1::Repositories::OrganizationRepository.filter(filtering_params) do |query|
            query.where('status > 0').where(visible: true).limit(25).order(status: :desc, created_at: :desc)
          end

        render json: Api::V1::Serializers::OrganizationSerializer.new(organizations)
      end

      def create
        organization = Api::V1::Services::OrgReqCreateService.new.call(organization_params)

        if organization.persisted?
          render json: Api::V1::Serializers::OrganizationRequestSerializer.new(organization), status: :created, location: organization
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      def show
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
