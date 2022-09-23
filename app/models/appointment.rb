class Appointment < ApplicationRecord
  belongs_to :client, class: "User"
  belongs_to :lawyer, class: "User" 
  belongs_to :tax_income
end
