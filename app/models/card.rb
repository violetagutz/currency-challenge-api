class Card < ApplicationRecord
  has_many :transactions
  validates :limit, presence: true
  validates :amount, numericality: { only_integer: true }
end
