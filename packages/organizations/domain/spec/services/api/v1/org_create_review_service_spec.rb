require 'rails_helper'

describe Api::V1::Services::OrgCreateReviewService, type: :service do
  subject(:service) { described_class.new }

  let(:organization) { create(:organization) }
  let(:user) { create(:user) }

  describe '#call' do
    let(:review_params) do
      {
        organization_id: organization.id,
        rating: 5,
        user_id: user.id,
        comment: 'test'
      }
    end

    it 'creates a review' do
      expect { service.call(user, review_params) }
        .to change(Api::V1::Repositories::ReviewRepository, :count)
        .by(1)
    end

    it 'enqueues log review job' do
      expect { service.call(user, review_params) }
        .to have_enqueued_job(OrgTrackNewReviewJob)
    end

    context 'with raise_error' do
      it 'raises an error if the organization is not found' do
        review_params[:organization_id] = 'not_found'

        expect { service.call(user, review_params, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raises an error if the user is not found' do
        review_params[:user_id] = '2347'

        expect { service.call(user, review_params, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raises an error if already reviewed' do
        service.call(user, review_params, raise_error: true)

        expect { service.call(user, review_params, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'raises an error if the rating is not valid' do
        review_params[:rating] = 6

        expect { service.call(user, review_params, raise_error: true) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'without raise_error' do
      it 'does not raise an error if the organization is not found' do
        review_params[:organization_id] = 'not_found'

        expect { service.call(user, review_params) }
          .not_to raise_error
        expect { service.call(user, review_params) }
          .not_to change(Api::V1::Repositories::ReviewRepository, :count)
        expect { service.call(user, review_params) }
          .not_to have_enqueued_job(OrgTrackNewReviewJob)
        expect(service.call(user, review_params).errors).not_to be_empty
      end

      it 'does not raise an error if the user is not found' do
        review_params[:user_id] = '2347'

        expect { service.call(user, review_params) }
          .not_to raise_error
        expect { service.call(user, review_params) }
          .not_to change(Api::V1::Repositories::ReviewRepository, :count)
        expect { service.call(user, review_params) }
          .not_to have_enqueued_job(OrgTrackNewReviewJob)
        expect(service.call(user, review_params).errors).not_to be_empty
      end

      it 'does not raise an error if already reviewed' do
        service.call(user, review_params)

        expect { service.call(user, review_params) }
          .not_to raise_error
        expect { service.call(user, review_params) }
          .not_to change(Api::V1::Repositories::ReviewRepository, :count)
        expect { service.call(user, review_params) }
          .not_to have_enqueued_job(OrgTrackNewReviewJob)
        expect(service.call(user, review_params).errors).not_to be_empty
      end

      it 'does not raise an error if the rating is not valid' do
        review_params[:rating] = 6

        expect { service.call(user, review_params) }
          .not_to raise_error
        expect { service.call(user, review_params) }
          .not_to change(Api::V1::Repositories::ReviewRepository, :count)
        expect { service.call(user, review_params) }
          .not_to have_enqueued_job(OrgTrackNewReviewJob)
        expect(service.call(user, review_params).errors).not_to be_empty
      end
    end
  end
end
