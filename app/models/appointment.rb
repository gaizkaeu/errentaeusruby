class Appointment < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :lawyer, class_name: "User" 
  belongs_to :tax_income

  after_create_commit :notify_creation_to_tax_income
  after_destroy_commit :notify_deletion_to_tax_income

  enum method: {
    phone: 0,
    office: 1
  }

  private 
  
  def notify_creation_to_tax_income
    tax_income.appointment_created!
  end

  def notify_deletion_to_tax_income
    tax_income.appointment_deleted!
  end




end
