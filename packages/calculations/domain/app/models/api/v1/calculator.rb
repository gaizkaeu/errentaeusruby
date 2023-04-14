class Api::V1::Calculator < ApplicationRecord
  include PrettyId

  self.id_prefix = 'calcr'

  belongs_to :organization, class_name: 'Api::V1::Organization'

  def predictor
    # rubocop:disable Security/MarshalLoad
    @predictor ||= Marshal.load(marshalled_predictor)
    # rubocop:enable Security/MarshalLoad
  end

  def predictor=(predictor)
    self.marshalled_predictor = Marshal.dump(predictor)
  end
end
