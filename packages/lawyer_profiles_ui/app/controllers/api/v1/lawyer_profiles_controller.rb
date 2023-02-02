# frozen_string_literal: true

module Api
  module V1
    class LawyerProfilesController < ::ApiBaseController
      before_action :authenticate
      before_action :set_lawyer_profile, only: %i[show update destroy]

      def index
        lawyer_profiles = Api::V1::Repositories::LawyerProfileRepository.filter(filtering_params)
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profiles, serializer_config)
      end

      def show
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(@lawyer_profile)
      end

      def me
        authorize Api::V1::LawyerProfile, :me?
        lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: current_user.id)
        render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile, { params: { manage: true } })
      end

      def create
        lawyer_profile = Api::V1::Services::LawProfCreateService.new.call(current_user, lawyer_profile_params_create)

        if lawyer_profile.persisted?
          render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile), status: :created, location: lawyer_profile
        else
          render json: lawyer_profile.errors, status: :unprocessable_entity
        end
      end

      def update
        lawyer_profile = Api::V1::Services::LawProfUpdateService.new.call(current_user, params[:id], lawyer_profile_params_update, raise_error: false)
        if lawyer_profile.errors.empty?
          render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile), status: :ok
        else
          render json: lawyer_profile.errors, status: :unprocessable_entity
        end
      end

      private

      def set_lawyer_profile
        @lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def lawyer_profile_params_create
        params.require(:lawyer_profile).permit(:organization_id, :avatar).merge!(user_id: current_user.id)
      end

      def lawyer_profile_params_update
        params.require(:lawyer_profile).permit(LawyerProfilePolicy.new(current_user, Api::V1::LawyerProfile).permitted_attributes_update)
      end

      def serializer_config
        LawyerProfilePolicy.new(current_user, Api::V1::LawyerProfile).serializer_config
      end

      def filtering_params
        params.require(:organization_id)
        params.slice(*Api::V1::Repositories::LawyerProfileRepository::FILTER_KEYS)
      end
    end
  end
end
