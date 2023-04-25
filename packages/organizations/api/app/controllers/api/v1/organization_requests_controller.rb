# frozen_string_literal: true

module Api
  module V1
    class OrganizationRequestsController < ApplicationController
      before_action :authenticate, except: %i[create]

      def create
        organization = OrganizationRequest.create!(organization_params)
        if organization.errors.empty?
          render json: Serializers::OrganizationRequestSerializer.new(organization),
                 status: :created,
                 location: organization
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      private

      def organization_params
        params.require(:organization_request).permit(:name, :email, :website, :phone, :city, :province)
      end
    end
  end
end
