class Card < ApplicationRecord
  has_many :transactions
  validates :limit, presence: true
  validates :limit, numericality: { only_integer: true }
end
