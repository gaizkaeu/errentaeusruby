# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ::ApiBaseController
      before_action :authenticate, except: %i[index show reviews]
      before_action :set_organization, only: %i[show update destroy]

      def index
        pagy, organizations = Api::V1::Services::OrgPublicIndexService.new.call(filtering_params)
        render json: Api::V1::Serializers::OrganizationSerializer.new(organizations, meta: pagy_metadata(pagy))
      end

      def show
        render json: Api::V1::Serializers::OrganizationSerializer.new(@organization)
      end

      private

      def set_organization
        @organization = Api::V1::Repositories::OrganizationRepository.find(params[:id])
      end

      def filtering_params
        fparams = params.slice(*Api::V1::Repositories::OrganizationRepository::FILTER_KEYS)
        # add pagination params if present add default values if not present
        fparams[:page] = params[:page] || 1
        fparams[:items] = params[:items] || 20

        fparams
      end
    end
  end
end
