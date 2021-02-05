class Card < ApplicationRecord

  has_many :transactions

  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true }

  def total_usage
    Transaction.where(card_id: self.id).sum(:amount)
  end

  def calculate_balance
    self.limit - self.total_usage
  end

end
