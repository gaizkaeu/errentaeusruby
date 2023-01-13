class Api::V1::OrganizationRecord < ApplicationRecord
  include PrettyId
  self.table_name = 'organizations'

  # self.id_prefix = -> (model) { model.account_type.to_s[0,4] } TODO: THINK ABOUT THIS
  self.id_prefix = 'org'

  extend T::Sig

  validates :name, presence: true, length: { maximum: 30, minimum: 4 }
  validates :location, presence: true, length: { maximum: 50, minimum: 4 }
  validates :phone, presence: true, length: { maximum: 10, minimum: 9 }
  validates :website, presence: true, length: { maximum: 50, minimum: 4 }
  validates :description, presence: true, length: { maximum: 100, minimum: 4 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  belongs_to :owner, class_name: 'Api::V1::UserRecord'

  include Filterable
end
