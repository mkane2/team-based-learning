# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = User.new({
  email: 'mkane2@albany.edu',
  password: 'book2445',
  password_confirmation: 'book2445',
  username: 'Prof. Kane',
  firstname: 'Prof.',
  lastname: "Kane",
  admin: "true"
  })
admin_user.save
