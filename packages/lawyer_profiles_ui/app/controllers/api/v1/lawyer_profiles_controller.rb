# frozen_string_literal: true

module Api
  module V1
    class LawyerProfilesController < ::ApiBaseController
      before_action :authenticate
      before_action :set_lawyer_profile, only: %i[show update destroy]

      def show
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(@lawyer_profile)
      end

      def me
        authorize Api::V1::LawyerProfile, :me?
        lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: current_user.id)
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile, { params: { manage: true } })
      end

      def create
        lawyer_profile = Api::V1::Services::CreateLawyerProfileService.new.call(current_user, lawyer_profile_params_create)

        if lawyer_profile.persisted?
          render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile), status: :created, location: lawyer_profile
        else
          render json: lawyer_profile.errors, status: :unprocessable_entity
        end
      end

      def update
        lawyer_profile = Api::V1::Services::UpdateLawyerProfileService.new.call(current_user, params[:id], lawyer_profile_params_update, raise_error: false)
        if lawyer_profile.errors.empty?
          render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile), status: :ok
        else
          render json: lawyer_profile.errors, status: :unprocessable_entity
        end
      end

      def destroy; end

      def handler
        render json: { error: 'not found' }, status: :unprocessable_entity
      end

      private

      def set_lawyer_profile
        @lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def lawyer_profile_params_create
        params.require(:lawyer_profile).permit(:organization_id, :avatar, :lawyer_status).merge!(user_id: current_user.id)
      end

      def lawyer_profile_params_update
        params.require(:lawyer_profile).permit(:avatar, :lawyer_status)
      end
    end
  end
end
