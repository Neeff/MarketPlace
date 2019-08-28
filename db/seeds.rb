# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Category.destroy_all
 categories = %w[technology home home_appliances sports beauty_personal_care
                 musical_instruments books toys]

categories.length.times do |i|
  Category.create(name: categories[i])
end