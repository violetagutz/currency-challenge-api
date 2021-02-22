class Card < ApplicationRecord

  has_many :transactions

  validates :limit, :number, presence: true
  validates :limit, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 10000,
                                    less_than: 100000000 }
  validates :number, uniqueness: true

  before_validation :add_random_number, on: :create

=begin
  def add_random_number
    # check if there is a card in the database with the number we just
    # generated. If exist (condition is true) generate other number

    # this is what we will use to check existance
    random_number

    random_number = 16.times.map{rand(1..9)}.join.to_i

    while Card.find_by(number: random_number)
      # generate a new random number and reassigned to the random_number
      # variable
      random_number = 16.times.map{rand(1..9)}.join.to_i
    end

    # set the random number to the number of the current card
    self.number = random_number

  end
=end

  def self.verify_transactions_per_card
    transactions_per_card = []
    self.find_each do |card|
      transactions = card.transactions
      transactions.verify_pending_transactions
      transactions_per_card << transactions
    end
    return transactions_per_card
  end

  def add_random_number
    self.number = 16.times.map{rand(1..9)}.join.to_i
    add_random_number if Card.find_by(number: number)
  end

  # get the total of the sum of all the amounts in that specifica card
  def sum_of_charges
    Transaction.where(card_id: self.id).sum(:amount)
  end

  # calculate the money left from the rest of limit minus sum of
  # charges
  def available_balance
    self.limit - self.sum_of_charges
  end

  def self.cards_with_high_sum_of_charges
    high_sum_cards = []
    self.all.each do |card|
      high_sum_cards << card if card.sum_of_charges > 100_000
    end
    return high_sum_cards
  end

  # all cards with minimum total usage of a certain amount
  def self.cards_minimum_total_usage(amount)
   minimum_total_usage_cards = []
   self.all.each do |card|
     minimum_total_usage_cards << card if card.sum_of_charges >= amount
   end
   return minimum_total_usage_cards
  end

  def average_transactions_amount
    Transaction.where(card_id: self.id).average(:amount).to_i * 2
  end

end
