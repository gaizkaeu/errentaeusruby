module Api
  module V1
    class OrganizationManageController < ApplicationController
      before_action :authenticate
      before_action :set_organization, except: %i[create index]

      def show
        render json: Serializers::OrganizationSerializer.new(@organization, serializer_params)
      end

      def create
        organization = Services::OrgCreateService.new.call(current_user, organization_params)

        if organization.errors.empty?
          render json: Serializers::OrganizationSerializer.new(organization, serializer_params), status: :created, location: organization
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      def update
        organization = Organization.update(@organization.id, organization_params)
        if organization.errors.empty?
          render json: Serializers::OrganizationSerializer.new(organization, serializer_params), status: :ok
        else
          render json: organization.errors, status: :unprocessable_entity
        end
      end

      private

      def set_organization
        @organization = Organization.find(params[:id])

        raise Pundit::NotAuthorizedError unless @organization.user_is_admin?(current_user.id)
      end

      def organization_params
        params.require(:organization_manage).permit(:name, :description, :website, :email, :phone, :city, :postal_code, :street, :province, :street, :prices, :visible, :logo, skill_list: [], company_target_list: [], service_list: [], settings: {})
      end

      def serializer_params
        { params: { skills: true, services: true, tags: true, targets: true, logo: true, manage: true } }
      end
    end
  end
end
