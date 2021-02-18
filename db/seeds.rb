# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
card = {
  limit: 100000,
}

card_one = Card.new(card)
card_one.save!

transaction = {
  amount: 200,
  card_id: 1,
  country: "USA"
}

transaction_one = Transaction.new(transaction)
transaction_one.save!

transaction = {
  amount: 300,
  card_id: 1,
  country: "Panama"
}

transaction_two = Transaction.new(transaction)
transaction_two.save!

transaction = {
  amount: 300,
  card_id: 1,
  country: "China"
}

transaction_three = Transaction.new(transaction)
transaction_three.save!

transaction = {
  amount: 200,
  card_id: 1,
  country: "Mexico"
}

transaction_four = Transaction.new(transaction)
transaction_four.save!
