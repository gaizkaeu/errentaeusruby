module Api::V1::Services
  class FindUserService
    include Authorization

    def call(current_account, filters = {}, id = nil)
      users = Api::V1::UserRecord.filter(filters, Api::V1::UserRecord.all)

      if id.present?
        user_record = users.find(id)
        raise ActiveRecord::RecordNotFound unless user_record

        user = Api::V1::User.new(user_record.attributes.symbolize_keys!)
        authorize_with current_account, user, :show?
        user
      else
        authorize_with current_account, current_account, :index?
        users.map do |u|
          Api::V1::User.new(u.attributes.symbolize_keys!)
        end
      end
    end
  end
end
