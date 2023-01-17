OrganizationPubSub = PubSubManager.new
OrganizationPubSub.register_event('organization.tax_income_assigned') { organization_id String }
OrganizationPubSub.register_event('organization.review_created') do
  organization_id String
  rating Integer
end

OrganizationPubSub.register_event('organization.review_deleted') do
  organization_id String
  rating Integer
end

OrganizationPubSub.subscribe('organization.tax_income_assigned', TrackNewTaxIncomeAssignationJob)
OrganizationPubSub.subscribe('organization.review_created', TrackNewReviewJob)
OrganizationPubSub.subscribe('organization.review_deleted', TrackDeletedReviewJob)
