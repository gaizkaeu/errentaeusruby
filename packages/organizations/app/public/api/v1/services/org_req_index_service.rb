class Api::V1::Services::OrgReqIndexService < ApplicationService
  include Pagy::Backend

  def call(filter_params)
    pagy, res = pagy(Api::V1::OrganizationRequestRecord.filter(filter_params, Api::V1::OrganizationRequestRecord.all), items: 20, page: filter_params[:page])

    mapped = Api::V1::Repositories::OrganizationRequestRepository.map_records(res)

    [pagy, mapped]
  end
end
