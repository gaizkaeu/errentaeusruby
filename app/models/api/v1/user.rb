# frozen_string_literal: true

require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

module Api
  module V1
    class User < ApplicationRecord
      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
      devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

      after_create_commit :create_stripe_customer

      has_many :tax_incomes, dependent: :destroy, inverse_of: :user
      has_many :estimations, dependent: :destroy, inverse_of: :user
      has_many :appointments, dependent: :destroy, through: :tax_incomes
      has_many :requested_documents, foreign_key: :user, dependent: :destroy, class_name: 'Document', inverse_of: :user
      has_many :asked_documents, foreign_key: :lawyer, dependent: :destroy, class_name: 'Document',  inverse_of: :laywer
      has_many :assigned_tax_incomes, foreign_key: :lawyer, class_name: 'TaxIncome', dependent: :destroy,  inverse_of: :lawyer

      enum account_type: { user: 0, lawyer: 1 }

      def create_stripe_customer
        # rubocop:disable Rails/SaveBang
        customer = Stripe::Customer.create({
                                            name: name + surname,
                                            email:,
                                            metadata: {
                                              user_id: id
                                            }
                                          })
        # rubocop:enable Rails/SaveBang
        update!(stripe_customer_id: customer['id'])
      end
    end
  end
end