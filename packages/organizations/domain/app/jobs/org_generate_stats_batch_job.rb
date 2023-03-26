class OrgGenerateStatsBatchJob
  include Cloudtasker::Worker

  def perform
    Api::V1::OrganizationRecord.find_each do |org|
      batch.add(OrgGenerateStatsJob, { organization_id: org.id })
    end
  end
end
