class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tax_incomes
  has_many :estimations
  has_many :appointments

  enum account_type: {user: 0, lawyer: 1}
end
