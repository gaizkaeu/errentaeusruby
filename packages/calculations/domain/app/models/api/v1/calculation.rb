class Api::V1::Calculation < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calcn'

  belongs_to :organization, class_name: 'Api::V1::Organization'
  belongs_to :calculator, class_name: 'Api::V1::Calculator'
  belongs_to :user, class_name: 'Api::V1::User'
end
