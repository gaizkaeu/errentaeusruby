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

admin_user = Api::V1::Repositories::UserRepository.add({ first_name: 'Gaizka', last_name: 'Urdangarin', account_type: :admin, account_id: admin.id }, raise_error: true)
owner = Api::V1::Repositories::UserRepository.add({ first_name: 'Eliza', last_name: 'Asesores', account_type: :org_manage, account_id: acc_gestion.id }, raise_error: true)
law = Api::V1::Repositories::UserRepository.add({ first_name: 'Carolina', last_name: 'Elizagarate', account_type: :lawyer, account_id: acc_lawyer.id }, raise_error: true)
org = Api::V1::Repositories::OrganizationRepository.add({ name: 'Eliza Asesores', phone: '1234567890', email: 'contacto@elizaasesores.com', website: 'https://www.elizaasesores.com', description: 'Eliza Asesores', latitude: 42.84, longitude: -2.67, owner_id: owner.id }, raise_error: true)
Api::V1::Repositories::LawyerProfileRepository.add({ user_id: law.id, organization_id: org.id, org_status: :accepted }, raise_error: true)
