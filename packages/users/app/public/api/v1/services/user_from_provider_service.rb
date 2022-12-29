class Api::V1::Services::UserFromProviderService < ApplicationService
  def call(auth, ip)
    user_record = find_user(auth)

    raise JWTSessions::Errors::Unauthorized unless user_record.persisted?

    UserPubSub.publish('user.logged_in', user_id: user_record.id, ip:, time: Time.now.iso8601.to_s, action: 0)

    Api::V1::User.new(user_record.attributes.symbolize_keys!)
  end

  private

  # rubocop:disable Metrics/AbcSize
  def find_user(auth)
    Api::V1::UserRecord.where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = SecureRandom.hex(32)
      user.first_name = auth.info.first_name # assuming the user model has a name
      user.last_name = auth.info.last_name # assuming the user model has a name
      user.confirmed_at = Time.zone.today
    end
  end
  # rubocop:enable Metrics/AbcSize
end
