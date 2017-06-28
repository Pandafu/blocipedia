# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'helloworld'
  )
end

5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'helloworld',
    role: 'premium'
    )
end

5.times do
  User.create!(
  email: Faker::Internet.unique.email,
  password: 'helloworld',
  role: 'admin'
  )
end

10.times do
  Wiki.create!(
    user: User.all.sample,
    title: Faker::StarWars.wookie_sentence,
    body: Faker::StarWars.quote,
    private: [true, false].sample,
    )

end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
