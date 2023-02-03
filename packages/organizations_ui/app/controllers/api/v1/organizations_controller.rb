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
        render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
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
