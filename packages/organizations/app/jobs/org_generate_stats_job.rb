class OrgGenerateStatsJob
  include Cloudtasker::Worker

  def perform
    logger.info('llego')
  end
end
