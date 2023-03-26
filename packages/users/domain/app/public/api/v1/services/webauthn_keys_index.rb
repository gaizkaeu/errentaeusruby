class Api::V1::Services::WebauthnKeysIndex < ApplicationService
  include Authorization

  def call(current_account, user_id, _filters = {})
    account_id = Api::V1::User.find(user_id).account_id
    account = Account.find(account_id)
    authorize_with current_account, account, :index_webauthn_keys?

    Account::WebauthnKey.where(account_id: account.id)
  end
end
