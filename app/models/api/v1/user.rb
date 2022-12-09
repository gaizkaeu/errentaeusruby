# frozen_string_literal: true

require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

module Api
  module V1
    class User < ApplicationRecord
      include Filterable
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable, 
            :recoverable, :rememberable, :validatable, :confirmable,
            :trackable, :omniauthable,
             omniauth_providers: [:google_one_tap]

      scope :filter_by_first_name, -> (name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").limit(10) }

      after_create_commit :create_stripe_customer, :send_welcome_email

      has_many :tax_incomes, dependent: :destroy, inverse_of: :client, foreign_key: :client
      has_many :estimations, dependent: :destroy, through: :tax_incomes
      has_many :appointments, dependent: :destroy, through: :tax_incomes
      has_many :requested_documents, foreign_key: :user, dependent: :destroy, class_name: 'Document', inverse_of: :user
      has_many :asked_documents, foreign_key: :lawyer, dependent: :destroy, class_name: 'Document',  inverse_of: :laywer
      has_many :account_histories, dependent: :destroy

      enum account_type: { user: 0, lawyer: 1 }

      def lawyer?
        account_type == "lawyer"
      end

      def create_stripe_customer
        return unless Rails.env.production?
        # rubocop:disable Rails/SaveBang
        customer = Stripe::Customer.create({
                                            name: first_name + (last_name || ''),
                                            email:,
                                            metadata: {
                                              user_id: id
                                            }
                                          })
        # rubocop:enable Rails/SaveBang
        update!(stripe_customer_id: customer['id'])
      end

      def send_welcome_email
        UserMailer.welcome_email(id).deliver_later!
        send_confirmation_instructions unless confirmed?
      end

      def resend_confirmation_instructions?
        if !confirmed? && confirmation_sent_at < (10.minutes.ago)
          update!(confirmation_sent_at: Time.current)
          send_confirmation_instructions
          true
        else
          false
        end
      end

      # rubocop:disable Metrics/AbcSize
      def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.first_name = auth.info.first_name # assuming the user model has a name
          user.last_name = auth.info.last_name # assuming the user model has a name
          user.confirmed_at = Time.zone.today
        end
      end
      # rubocop:enable Metrics/AbcSize

      def after_database_authentication
        LogAccountLoginJob.perform_async({user_id: id, action: 0, ip: current_sign_in_ip, time: current_sign_in_at,}.stringify_keys)
      end

      def after_provider_authentication(provider_data)
        LogAccountLoginJob.perform_async({user_id: id, action: 0, ip: current_sign_in_ip, time: current_sign_in_at,}.merge(provider_data).stringify_keys)
      end
    end
  end
end