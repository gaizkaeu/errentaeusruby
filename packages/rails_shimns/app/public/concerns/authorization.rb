module Authorization
  extend ActiveSupport::Concern

  include Pundit::Authorization

  def pundit_user
    current_user
  end

  def authorize_with(user, record, query, policy_class: nil)
    Pundit.authorize(user, record, query, policy_class:)
  end
end
