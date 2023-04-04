class Api::V1::EmailsController < ApplicationController
  def create
    call = Api::V1::EmailContact.new(email_params)
    call.user = current_user if current_account.present?

    if call.save
      render json: call, status: :created
    else
      render json: call.errors, status: :unprocessable_entity
    end
  end

  private

  def email_params
    params.require(:email).permit(:organization_id, :first_name, :last_name, :email)
  end
end
