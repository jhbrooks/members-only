# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Example User",
             password: "foobar",
             password_confirmation: "foobar")

5.times do |n|
  name = Faker::Name.name
  password = "password"
  User.create!(name: name,
               password: password,
               password_confirmation: password)
end

60.times do |n|
  user = User.order(:created_at).offset(n / 10).first
  body = Faker::Lorem.paragraph
  user.posts.build(body: body).save!
end
