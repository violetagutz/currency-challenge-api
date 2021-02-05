class Card < ApplicationRecord

  has_many :transactions

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true,
                                    greater_than: 10000,
                                    less_than: 100000000 }

  def sum_of_transactions
    Transaction.where(card_id: self.id).sum(:amount)
  end

  def calculate_balance
    self.limit - self.sum_of_transactions
  end

end
