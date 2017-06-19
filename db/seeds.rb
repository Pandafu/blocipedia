# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'


10.times do
  Wiki.create!(
  user: Faker::StarWars.character
  title: Faker::StarWars.wookie_sentence
  body: Faker::StarWars.quote
  )

  wikis = Wiki.all
end

puts "Seed finished"
puts "#{Wiki.count} wikis created"
