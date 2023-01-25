class OrgGenerateStatsBatchJob
  include Cloudtasker::Worker

  def perform
    3.times { |_n| batch.add(OrgGenerateStatsJob) }
  end
end
