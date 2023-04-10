class Api::V1::OrganizationCalculator < ApplicationRecord
  include PrettyId

  self.id_prefix = 'org_calc'

  belongs_to :organization, class_name: 'Api::V1::Organization'
end
