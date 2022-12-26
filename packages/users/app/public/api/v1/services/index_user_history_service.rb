class Api::V1::Services::IndexUserHistoryService < ApplicationService
  include Authorization

  def call(current_account, user_id, _filters = {})
    target_user = Api::V1::UserRepository.find(user_id)
    authorize_with current_account, target_user, :access_history?

    Api::V1::AccountHistoryRecord.where(user_id:).order(time: :desc).limit(19).map do |history|
      Api::V1::AccountHistory.new(history)
    end
  end
end
