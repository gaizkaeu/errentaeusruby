# rubocop:disable Style/StaticClass
class ApplicationService
  def self.call(*args)
    new.call(*args)
  end
end
# rubocop:enable Style/StaticClass
