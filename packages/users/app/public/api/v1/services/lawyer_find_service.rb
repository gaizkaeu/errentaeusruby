class Api::V1::Services::LawyerFindService < ApplicationService
  def call(id, raise_error: false)
    target = Api::V1::Repositories::UserRepository.where(account_type: :lawyer, id:).first
    raise ActiveRecord::RecordNotFound if target.blank? && raise_error

    target
  end
end
