module Api::V1::AppointmentRepository
  def self.where(**kargs)
    Api::V1::AppointmentRecord.where(**kargs).map do |record|
      Api::V1::AppointmentRecord.new(record.attributes.symbolize_keys!)
    end
  end

  def self.find_by!(**kargs)
    record = Api::V1::AppointmentRecord.find_by!(**kargs)
    Api::V1::Appointment.new(record.attributes.symbolize_keys!)
  end

  def self.find(id)
    record = Api::V1::AppointmentRecord.find(id)
    Api::V1::Appointment.new(record.attributes.symbolize_keys!)
  end

  def self.add(user)
    record = Api::V1::AppointmentRecord.create!(user.to_hash)
    user = Api::V1::Appointment.new(record.attributes.symbolize_keys!)
    user.instance_variable_set(:@errors, record.errors)
    user
  end

  def self.count
    Api::V1::AppointmentRecord.count
  end
end
