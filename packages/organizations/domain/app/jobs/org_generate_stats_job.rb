class OrgGenerateStatsJob
  include Cloudtasker::Worker

  def perform(params)
    Api::V1::Services::OrgCreateStatsService.new.call(params['organization_id'], raise_error: true)
  end
end
