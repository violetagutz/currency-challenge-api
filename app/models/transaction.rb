class Transaction < ApplicationRecord

  belongs_to :card, dependent: :destroy

  validates :amount, :card_id, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  # get average of charges amount of current card

end
