module Authorization
  extend ActiveSupport::Concern

  include Pundit::Authorization

  def pundit_user
    current_user
  end

  def authorize_with(user, record, query)
    Pundit.authorize(user, record, query)
  end
end
