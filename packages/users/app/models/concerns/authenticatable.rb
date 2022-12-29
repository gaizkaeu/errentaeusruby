module Authenticatable
  extend ActiveSupport::Concern

  included do
    has_secure_password
    validates :email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :email, uniqueness: { case_sensitive: false }
    validates :uid, uniqueness: { scope: :provider }

    validates :password, presence: true, on: :create
    validates :password, length: { minimum: 5 }, on: :create
    validates :password, password_update: true, on: :update

    attr_readonly :uid, :provider, :email
    attr_readonly :password_digest, unless: :can_update_password?

    before_validation :set_defaults
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

  def set_defaults
    self.uid = email if uid.blank?
  end

  def confirmed?
    confirmed_at.present?
  end

  def can_update_password?
    provider == 'email'
  end
end
