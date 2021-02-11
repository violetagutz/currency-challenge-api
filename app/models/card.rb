class Card < ApplicationRecord

  has_many :transactions

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 10000,
                                    less_than: 100000000 }

  def sum_of_charges
    Transaction.where(card_id: self.id).sum(:amount)
  end

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
