class Api::V1::Serializers::OrganizationStatSerializer
  include JSONAPI::Serializer

  set_type :organization_stat
  set_id :id

  attributes :lawyers_active_count, :lawyers_active_count_acc
  attributes :lawyers_inactive_count, :lawyers_inactive_count_acc
  attributes :tax_income_count, :tax_income_count_acc
  attributes :one_star_count, :one_star_count_acc
  attributes :two_star_count, :two_star_count_acc
  attributes :three_star_count, :three_star_count_acc
  attributes :four_star_count, :four_star_count_acc
  attributes :five_star_count, :five_star_count_acc
  attributes :balance_today
  attributes :balance_capturable_today
  attributes :date

  belongs_to :organization, record_type: :organization, serializer: Api::V1::Serializers::OrganizationSerializer
end
