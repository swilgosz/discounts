# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.create([
  { name: "Green Tea", code: "GR1", price: 3.11 },
  { name: "Strawberies", code: "STR1", price: 5.00 },
  { name: "Coffee", code: "CF1", price: 11.23 }
])
