# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Api::V1::UserRecord.create!(
  first_name: 'Carolina',
  last_name: 'Elizagarate',
  password: 'jhasduYhasdhahgh',
  email: 'gestion@elizaasesores.com',
  account_type: :lawyer,
  confirmed_at: '02-04-2002',
  uid: '106288476163892547359',
  provider: 'google_oauth2'
)
