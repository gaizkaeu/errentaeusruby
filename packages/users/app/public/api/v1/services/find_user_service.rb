class Api::V1::Services::FindUserService < ApplicationService
  include Authorization

  def call(current_account, filters = {}, id = nil)
    if id.nil?
      authorize_with current_account, current_account, :index?
      Api::V1::UserRepository.filter(filters)
    else
      user = Api::V1::UserRepository.find(id)
      authorize_with current_account, user, :show?
      user
    end
  end
end
