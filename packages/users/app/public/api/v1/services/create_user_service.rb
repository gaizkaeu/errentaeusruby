class Api::V1::Services::CreateUserService < ApplicationService
  def call(user, _ip = '0.0.0.0', raise_error: false)
    Api::V1::Repositories::UserRepository.add(user, raise_error:)
  end
end
