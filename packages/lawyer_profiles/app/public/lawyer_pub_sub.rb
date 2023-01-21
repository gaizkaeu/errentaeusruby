LawyerPubSub = PubSubManager.new
LawyerPubSub.register_event('lawyer.tax_income_assigned') { lawyer_id String }
LawyerPubSub.register_event('lawyer.review_created') do
  organization_id String
  rating Integer
end

LawyerPubSub.register_event('lawyer.review_deleted') do
  organization_id String
  rating Integer
end

LawyerPubSub.subscribe('lawyer.tax_income_assigned', LawTrackNewTaxIncomeAssignationJob)
LawyerPubSub.subscribe('lawyer.review_created', LawTrackNewReviewJob)
LawyerPubSub.subscribe('lawyer.review_deleted', LawTrackDeletedReviewJob)
