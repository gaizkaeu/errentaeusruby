OrganizationPubSub = PubSubManager.new
OrganizationPubSub.register_event('organization.tax_income_assigned') do
  organization_id String
  date String
end

OrganizationPubSub.register_event('organization.lawyer_change') do
  organization_id String
  lawyer_id String
end

OrganizationPubSub.register_event('organization.review_created') do
  organization_id String
  date String
  rating Integer
end

OrganizationPubSub.register_event('organization.review_deleted') do
  organization_id String
  date String
  rating Integer
end

OrganizationPubSub.register_event('organization.request_created') do
  organization_request_id String
end

OrganizationPubSub.subscribe('organization.tax_income_assigned', OrgTrackNewTaxIncomeAssignationJob)
OrganizationPubSub.subscribe('organization.review_created', OrgTrackNewReviewJob)
OrganizationPubSub.subscribe('organization.review_deleted', OrgTrackDeletedReviewJob)
OrganizationPubSub.subscribe('organization.request_created', OrgRequestNotificationJob)
