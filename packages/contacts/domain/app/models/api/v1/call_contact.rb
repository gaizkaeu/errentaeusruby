class Api::V1::CallContact < ApplicationRecord
  include PrettyId
  include Api::V1::Concerns::Contactable

  self.id_prefix = 'org_call'

  STATUSES = %w[pending live finished].freeze
  private_constant :STATUSES

  validates :state, inclusion: { in: STATUSES }

  def self.ransackable_attributes(_auth_object = nil)
    ['successful']
  end

  def start
    if state == 'pending'
      update!(state: 'live', start_at: Time.current)
    else
      errors.add(:state, 'is not pending')
      false
    end
  end

  def end
    if state == 'live'
      update!(state: 'finished', end_at: Time.current, duration: Time.current - start_at)
    else
      errors.add(:state, 'is not live')
      false
    end
  end
end
