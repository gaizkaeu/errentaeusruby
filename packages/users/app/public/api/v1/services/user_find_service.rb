class Api::V1::Services::UserFindService < ApplicationService
  include Authorization

  def call(current_account, filters = {}, id = nil)
    if id.nil?
      authorize_with current_account, Api::V1::User, :index?
      Api::V1::Repositories::UserRepository.filter(filters)
    else
      user = Api::V1::Repositories::UserRepository.find(id)
      authorize_with current_account, user, :show?
      user
    end
  end
end
