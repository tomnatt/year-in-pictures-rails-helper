# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_email = ENV['YIP_HELPER_EMAIL'] || 'admin@example.com'
admin_password = ENV['YIP_HELPER_PASSWORD'] || 'password'
admin = User.create(email: admin_email, password: admin_password)
