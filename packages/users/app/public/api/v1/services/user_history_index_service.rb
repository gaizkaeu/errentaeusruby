class Api::V1::Services::UserHistoryIndexService < ApplicationService
  include Authorization

  def call(current_account, user_id, _filters = {})
    target_user = Api::V1::Repositories::UserRepository.find(user_id)
    authorize_with current_account, target_user, :access_history?

    Account::AuthenticationAuditLog.where(account_id: target_user.account_id).order(at: :desc).limit(10).map do |history|
      Api::V1::AccountHistory.new(history)
    end
  end
end
