class Api::V1::Services::OrgPublicIndexService < ApplicationService
  include Pagy::Backend

  def call(filter_params)
    pagy, res = pagy(
      Api::V1::OrganizationRecord.filter(filter_params, Api::V1::OrganizationRecord.all)
                              .order(status: :desc)
                              .order(avg_rating: :desc)
                              .order(created_at: :asc),
      items: 20,
      page: filter_params[:page]
    )

    mapped = Api::V1::Repositories::OrganizationRepository.map_records(res)

    [pagy, mapped]
  end
end
