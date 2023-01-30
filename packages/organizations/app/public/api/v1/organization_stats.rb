class Api::V1::OrganizationStats
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations

  extend T::Sig

  attr_reader :id, :lawyers_active_count, :lawyers_active_count_acc, :lawyers_inactive_count, :lawyers_inactive_count_acc, :tax_income_count, :tax_income_count_acc, :one_star_count, :one_star_count_acc, :two_star_count, :two_star_count_acc, :three_star_count, :three_star_count_acc, :four_star_count, :four_star_count_acc, :five_star_count, :five_star_count_acc, :date, :organization_id, :balance

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def initialize(attributes = {})
    @id = attributes.fetch(:id, nil)
    @lawyers_active_count = attributes.fetch(:lawyers_active_count, 0)
    @lawyers_active_count_acc = attributes.fetch(:lawyers_active_count_acc, 0)
    @lawyers_inactive_count = attributes.fetch(:lawyers_inactive_count, 0)
    @lawyers_inactive_count_acc = attributes.fetch(:lawyers_inactive_count_acc, 0)
    @tax_income_count = attributes.fetch(:tax_income_count, 0)
    @tax_income_count_acc = attributes.fetch(:tax_income_count_acc, 0)
    @one_star_count = attributes.fetch(:one_star_count, 0)
    @one_star_count_acc = attributes.fetch(:one_star_count_acc, 0)
    @two_star_count = attributes.fetch(:two_star_count, 0)
    @two_star_count_acc = attributes.fetch(:two_star_count_acc, 0)
    @three_star_count = attributes.fetch(:three_star_count, 0)
    @three_star_count_acc = attributes.fetch(:three_star_count_acc, 0)
    @four_star_count = attributes.fetch(:four_star_count, 0)
    @four_star_count_acc = attributes.fetch(:four_star_count_acc, 0)
    @five_star_count = attributes.fetch(:five_star_count, 0)
    @five_star_count_acc = attributes.fetch(:five_star_count_acc, 0)
    @date = attributes.fetch(:date, nil)
    @balance = attributes.fetch(:balance, 0)
    @organization_id = attributes.fetch(:organization_id, nil)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id && name == other.name
  end
end
