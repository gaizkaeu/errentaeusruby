class Api::V1::Services::UpdateUserService
  include Authorization

  def call(current_account, id, params, raise_error: false)
    user = Api::V1::Repositories::UserRepository.find(id)
    authorize_with current_account, user, :update?

    Api::V1::Repositories::UserRepository.update(id, params, raise_error:)
  end
end
