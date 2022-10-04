class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tax_incomes
  has_many :estimations
  has_many :appointments

  has_many :assigned_tax_incomes, ->(self_o) { where lawyer_id: self_o.id }, class_name: "TaxIncome", foreign_key: "lawyer_id"

  enum account_type: {user: 0, lawyer: 1}
end
