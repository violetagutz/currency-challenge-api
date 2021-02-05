class Transaction < ApplicationRecord
  belongs_to :card
  validates :amount, :card_id, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

end
