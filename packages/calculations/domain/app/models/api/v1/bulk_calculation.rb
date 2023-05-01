class Api::V1::BulkCalculation < ApplicationRecord
  include PrettyId
  self.id_prefix = 'bcalc'

  belongs_to :user, class_name: 'Api::V1::User'
  belongs_to :calculation_topic, class_name: 'Api::V1::CalculationTopic'

  has_many :calculations, class_name: 'Api::V1::Calculation', dependent: :destroy
  has_many :calculators, through: :calculations, class_name: 'Api::V1::Calculator'
end
