class Api::V1::OrganizationRequest < ApplicationRecord
  include PrettyId

  self.id_prefix = 'org_req'
end
