module Api::V1::Concerns::Contactable
  extend ActiveSupport::Concern

  included do
    belongs_to :calculation, class_name: 'Api::V1::Calculation', optional: true
    has_one :calculator, through: :calculation, class_name: 'Api::V1::Calculator'
    belongs_to :organization, class_name: 'Api::V1::Organization'
    belongs_to :user, class_name: 'Api::V1::User', optional: true

    acts_as_taggable_on :interested_in

    after_create_commit do
      OrganizationPubSub.publish(
        'organization.notification',
        organization_id:,
        message: {
          subject: 'Solicitud de contacto',
          content: "Accede a tu panel de control para ver la solicitud de contacto de #{first_name} #{last_name}"
        }
      )
    end
  end

  def first_name
    user&.first_name || attributes['first_name']
  end

  def last_name
    user&.last_name || attributes['last_name']
  end
end
