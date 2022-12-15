module Authenticatable
    extend ActiveSupport::Concern

    included do
      has_secure_password
      validates_presence_of :email
      validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
      validates :email, uniqueness: true
      validates :uid, uniqueness: { scope: :provider }

      validates_presence_of :password
      validates :password, length: {minimum: 5}
    end

    def send_welcome_email
        UserMailer.welcome_email(id).deliver_later! if Rails.env.production?
        # send_confirmation_instructions unless confirmed?
    end

    def resend_confirmation_instructions?
        if !confirmed? && confirmation_sent_at < (10.minutes.ago)
            update!(confirmation_sent_at: Time.current)
            # send_confirmation_instructions TODO:
            true
        else
            false
        end
    end

    # rubocop:disable Metrics/AbcSize
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
            user.email = auth.info.email
            user.password = SecureRandom.hex(32)
            user.first_name = auth.info.first_name # assuming the user model has a name
            user.last_name = auth.info.last_name # assuming the user model has a name
            user.confirmed_at = Time.zone.today
        end
    end
    # rubocop:enable Metrics/AbcSize

    def after_database_authentication
        LogAccountLoginJob.perform_async({ user_id: id, action: 0, ip: current_sign_in_ip, time: current_sign_in_at  }.stringify_keys)
    end

    def after_provider_authentication(provider_data)
        LogAccountLoginJob.perform_async({ user_id: id, action: 0, ip: current_sign_in_ip, time: current_sign_in_at  }.merge(provider_data).stringify_keys)
    end

    def set_defaults
        self.uid = email if uid.blank?
    end

    def confirmed?
        confirmed_at.present?
    end
end
