class Api::V1::OrganizationRecord < ApplicationRecord
  PRICES_JSON_SCHEMA = Rails.root.join('config', 'schemas', 'org_prices.json')

  private_constant :PRICES_JSON_SCHEMA

  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'organizations'

  # self.id_prefix = -> (model) { model.account_type.to_s[0,4] } TODO: THINK ABOUT THIS
  self.id_prefix = 'org'

  validates :name, presence: true, length: { maximum: 30, minimum: 4 }
  validates :location, presence: true, length: { maximum: 50, minimum: 4 }
  validates :phone, presence: true, length: { maximum: 10, minimum: 9 }
  validates :website, presence: true, length: { maximum: 50, minimum: 4 }
  validates :description, presence: true, length: { maximum: 100, minimum: 4 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :prices, json: { schema: PRICES_JSON_SCHEMA }

  belongs_to :owner, class_name: 'Api::V1::UserRecord'
end
