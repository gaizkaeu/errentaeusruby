# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ::ApiBaseController
      before_action :authenticate, except: %i[index show reviews]
      before_action :set_organization, only: %i[show update destroy]

      def index
        organizations =
          Api::V1::Repositories::OrganizationRepository.filter(filtering_params) do |query|
            query.where('status > 0').limit(25).order(status: :desc, created_at: :desc)
          end

        render json: Api::V1::Serializers::OrganizationSerializer.new(organizations)
      end

      def show
        authorize @organization, :show?
        render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
      end

      def lawyers
        lawyers = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params.merge!(organization_id: params[:id], org_status: 'accepted'))
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyers)
      end

      def handler
        render json: { error: 'not found' }, status: :unprocessable_entity
      end

      private

      def set_organization
        @organization = Api::V1::Repositories::OrganizationRepository.find(params[:id])
      end

      def filtering_params
        params.slice(*Api::V1::Repositories::OrganizationRepository::FILTER_KEYS)
      end
    end
  end
end
