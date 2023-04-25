# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :authenticate, except: %i[index show reviews]
      before_action :set_organization, only: %i[show update destroy]

      def index
        pagy, orgs = pagy(
          Organization.includes(%i[taggings logo_attachment])
                                      .ransack(params[:q])
                                      .result
                                      .where(visible: true)
        )

        render json: Serializers::OrganizationSerializer.new(orgs, meta: pagy_metadata(pagy))
      end

      def show
        render json: Serializers::OrganizationSerializer.new(@organization)
      end

      private

      def set_organization
        @organization = Organization.find(params[:id])

        render json: { error: 'Organization not found' }, status: :not_found unless @organization.visible
      end
    end
  end
end
