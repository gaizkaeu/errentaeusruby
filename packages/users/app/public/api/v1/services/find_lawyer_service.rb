class Api::V1::Services::FindLawyerService < ApplicationService
  def call(id)
    user_record = Api::V1::UserRecord.where(account_type: :lawyer).find(id)
    raise ActiveRecord::RecordNotFound unless user_record

    Api::V1::User.new(user_record.attributes.symbolize_keys!)
  end
end
