OrganizationPubSub = PubSubManager.new

OrganizationPubSub.register_event('organization.created') do
  id String
end

OrganizationPubSub.register_event('organization.updated') do
  id String
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

OrganizationPubSub.register_event('organization.invitation_created') do
  organization_inv_id String
end

OrganizationPubSub.subscribe('organization.review_created', OrgTrackNewReviewJob)
OrganizationPubSub.subscribe('organization.review_deleted', OrgTrackDeletedReviewJob)
OrganizationPubSub.subscribe('organization.request_created', OrgRequestNotificationJob)

# Register external package events

CustomerSubscriptionDeletedPubSub.subscribe(
  Api::V1::Services::OrgSubscriptionDeletedService,
  /org_*/,
  synchronous: true
)
CustomerSubscriptionUpdatedPubSub.subscribe(
  Api::V1::Services::OrgSubscriptionUpdatedService,
  /org_*/,
  synchronous: true
)
