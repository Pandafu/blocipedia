# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
  Wiki.create!([{
    user_id: 1,
    title: Faker::StarWars.wookie_sentence,
    body: Faker::StarWars.quote,
    private: [true, false].sample
  }])

  wikis = Wiki.all
end

puts "Seed finished"
puts "10 wikis created"
