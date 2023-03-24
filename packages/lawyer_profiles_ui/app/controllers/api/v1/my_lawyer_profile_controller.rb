# frozen_string_literal: true

class Api::V1::MyLawyerProfileController < ApiBaseController
  before_action :authenticate
  before_action :set_lawyer_profile, only: %i[show update destroy]

  def show
    render json: Api::V1::Serializers::LawyerProfileSerializer.new(@lawyer_profile, serializer_config)
  end

  def create
    lawyer_profile = Api::V1::Services::LawProfCreateService.new.call(current_user, law_prof_params)

    if lawyer_profile.persisted?
      render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile), status: :created, location: lawyer_profile
    else
      render json: lawyer_profile.errors, status: :unprocessable_entity
    end
  end

  def update
    lawyer_profile = Api::V1::Services::LawProfUpdateService.new.call(current_user, @lawyer_profile.id, law_prof_params, raise_error: false)
    if lawyer_profile.errors.empty?
      render json: Api::V1::Serializers::LawyerProfileSerializer.new(lawyer_profile, serializer_config), status: :ok
    else
      render json: lawyer_profile.errors, status: :unprocessable_entity
    end
  end

  private

  def set_lawyer_profile
    @lawyer_profile = Api::V1::Repositories::LawyerProfileRepository.find_by!(user_id: current_user.id)
  end

  def law_prof_params
    params.require(:my_lawyer_profile).permit(:phone, :email, :on_duty, skill_list: []).merge(user_id: current_user.id)
  end

  def serializer_config
    {
      params: {
        manage: true
      }
    }
  end
end
