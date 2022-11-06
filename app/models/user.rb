
require 'stripe'
Stripe.api_key = 'sk_test_51LxvpDGrlIhNYf6eyMiOoOdSbL3nqJzwj53cNFmE8S6ZHZrzWEE5uljuObcKniylLkgtMKgQOg2Oc865VTG0DqTd00oTgt6imP'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create_commit :create_stripe_customer

  has_many :tax_incomes
  has_many :estimations
  has_many :appointments
  has_many :requested_documents, foreign_key: :requested_by, dependent: :destroy, class_name: "Document"
  has_many :asked_documents, foreign_key: :requested_to, dependent: :destroy, class_name: "Document"
  has_many :assigned_tax_incomes, foreign_key: :lawyer_id, class_name: "TaxIncome"

  enum account_type: {user: 0, lawyer: 1}

  def create_stripe_customer
    customer = Stripe::Customer.create({
      name: name + surname,
      email: email,
      metadata: {
        user_id: id
      }
    })
    self.update!(stripe_customer_id: customer['id'])
  end
end
