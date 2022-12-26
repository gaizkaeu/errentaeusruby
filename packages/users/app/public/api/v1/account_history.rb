class Api::V1::AccountHistory
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include ActiveModel::Validations
  extend T::Sig

  attr_reader :id, :user_id, :action, :time, :uid, :provider, :ip

  def initialize(attributes = {})
    @id = attributes[:id]
    @user_id = attributes[:user_id]
    @action = attributes[:action]
    @time = attributes[:time]
    @uid = attributes[:uid]
    @provider = attributes[:provider]
    @ip = attributes[:ip]
  end

  def persisted?
    !!id
  end

  def ==(other)
    id == other.id
  end
end
