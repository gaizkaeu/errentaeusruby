# frozen_string_literal: true

require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

module Api
  module V1
    class User < ApplicationRecord
      include Filterable
      include Authenticatable

      scope :filter_by_all_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").limit(10) }
      scope :filter_by_client_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :client).limit(10) }
      scope :filter_by_lawyer_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :lawyer).limit(10) }

      after_create_commit :create_stripe_customer, :send_welcome_email
      before_validation :set_defaults

      has_many :tax_incomes, dependent: :destroy, inverse_of: :client, foreign_key: :client
      has_many :estimations, dependent: :destroy, through: :tax_incomes
      has_many :appointments, dependent: :destroy, through: :tax_incomes
      has_many :requested_documents, foreign_key: :user, dependent: :destroy, class_name: 'Document', inverse_of: :user
      has_many :asked_documents, foreign_key: :lawyer, dependent: :destroy, class_name: 'Document', inverse_of: :laywer
      has_many :account_histories, dependent: :destroy

      enum account_type: { client: 0, lawyer: 1 }

      def lawyer?
        account_type == 'lawyer'
      end

      def client?
        account_type == 'client'
      end

      def create_stripe_customer
        return unless Rails.env.production?

        # rubocop:disable Rails/SaveBang
        customer = Stripe::Customer.create(
          {
            name: (first_name || id) + (last_name || ''),
            email:,
            metadata: {
              user_id: id
            }
          }
        )
        # rubocop:enable Rails/SaveBang
        update!(stripe_customer_id: customer['id'])
      end

    end
  end
end
