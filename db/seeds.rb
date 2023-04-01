# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Account.create!(email: 'gaizkaurdangarin@gmail.com', status: 2)
acc_gestion = Account.create!(email: 'gestion@elizaasesores.com', status: 2)
acc_lawyer = Account.create!(email: 'carolina@elizaasesores.com', status: 2)

Api::V1::User.create!({ first_name: 'Gaizka', last_name: 'Urdangarin', account_id: admin.id })
owner = Api::V1::User.create!({ first_name: 'Eliza', last_name: 'Asesores', account_type: :org_manage, account_id: acc_gestion.id })
law = Api::V1::User.create!({ first_name: 'Carolina', last_name: 'Elizagarate', account_type: :lawyer, account_id: acc_lawyer.id })
org = Api::V1::Organization.create!({ name: 'Eliza Asesores', phone: '1234567890', email: 'contacto@elizaasesores.com', website: 'https://www.elizaasesores.com', description: 'Eliza Asesores', latitude: 42.84, longitude: -2.67 })
Api::V1::OrganizationMembership.create!({ user_id: owner.id, organization_id: org.id, role: :admin })
