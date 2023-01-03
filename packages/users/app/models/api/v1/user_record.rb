# frozen_string_literal: true

require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

module Api
  module V1
    class UserRecord < ApplicationRecord
      include PrettyId
      self.table_name = 'users'

      # self.id_prefix = -> (model) { model.account_type.to_s[0,4] } TODO: THINK ABOUT THIS
      self.id_prefix = 'usr'

      extend T::Sig

      include Filterable

      attr_readonly :account_type

      scope :filter_by_all_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").limit(10) }
      scope :filter_by_client_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :client).limit(10) }
      scope :filter_by_lawyer_first_name, ->(name) { where("lower(first_name || ' ' || last_name) like ?", "%#{name.downcase}%").where(account_type: :lawyer).limit(10) }

      enum account_type: { client: 0, lawyer: 1 }

      validates_presence_of :first_name, :last_name, :account_type

      validates :first_name, length: { maximum: 15, minimum: 2 }

      belongs_to :account, class_name: 'Account', inverse_of: :user, optional: true

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

      def block
        update(blocked: true)
      end

      def block!
        update!(blocked: true)
      end
    end
  end
end
