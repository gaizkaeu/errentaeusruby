# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ::ApiBaseController
      before_action :authenticate
      before_action :set_organization, only: %i[show update destroy]

      def index
        organizations = Api::V1::Repositories::OrganizationRepository.filter(filtering_params)
        render json: Api::V1::Serializers::OrganizationSerializer.new(organizations)
      end

      def show
        render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
      end

      def create
        organization = Api::V1::Services::CreateOrganizationService.new.call(current_user, organization_params)

        if organization.persisted?
          render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :created, location: organization
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      def update
        organization = Api::V1::Services::UpdateOrganizationService.new.call(current_user, params[:id], organization_params, raise_error: false)
        if organization.errors.empty?
          render json: Api::V1::Serializers::OrganizationSerializer.new(organization), status: :ok
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      def lawyers
        lawyers = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params.merge!(organization_id: params[:id], org_status: 'accepted'))
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyers)
      end

      def destroy; end

      def handler
        render json: { error: 'not found' }, status: :unprocessable_entity
      end

      private

      def set_organization
        @organization = Api::V1::Repositories::OrganizationRepository.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def organization_params
        params.require(:organization).permit(:name, :description, :website, :email, :phone, :location, :prices).merge!(owner_id: current_user.id)
      end

      def filtering_params
        params.slice(Api::V1::Repositories::OrganizationRepository::FILTER_KEYS)
      end
    end
  end
end
