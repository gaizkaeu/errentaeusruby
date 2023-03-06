class Api::V1::OrganizationRequestRecord < ApplicationRecord
  include PrettyId
  include Filterable
  extend T::Sig

  self.table_name = 'organization_requests'
  self.id_prefix = 'org_req'
end
