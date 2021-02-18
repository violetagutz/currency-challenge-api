class Transaction < ApplicationRecord

  belongs_to :card, dependent: :destroy

  validates :amount, :card_id, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  enum state: { "pending": 0, "declined": 1 }

  scope :pending, -> { where(state: "pending") }

  def self.group_transactions_by_amount

    transactions_by_amount = {}

    self.pending.each do |transaction|
      # getting the amount out of transaction
      amount = transaction[:amount]
      # set an array as a value of the hash with the key of amount
      transactions_array = transactions_by_amount[amount]
      # if array has values in it, add the transaction to it
      if transactions_array
        transactions_array.push(transaction)
        # updating the hash with the new value in the array
        transactions_by_amount[amount] = transactions_array
      else
        # create a new array
        transactions_array = []
        # add the transaction to it as the first value
        transactions_array.push(transaction)
        # update the hash value with the new element in the array
        transactions_by_amount[amount] = transactions_array
      end
    end
    # returns a Hash
    return transactions_by_amount
  end

  def self.check_duplicates

    transactions_by_amount = self.group_transactions_by_amount

    transactions_by_amount.keys.each do |transactions_amount|

      array_of_transactions = transactions_by_amount[transactions_amount]

      array_pending_transactions = []

      if array_of_transactions.length > 1
        first_transaction = array_of_transactions.shift
        array_pending_transactions.push(first_transaction)
        updated_array = array_of_transactions
        updated_array.each do |transaction|
          transaction.state = "declined"
          transaction.save
        end
      else
        array_pending_transactions = transactions_by_amount
      end
      return array_pending_transactions
    end
  end

  def self.verify_pending_transactions
    self.check_duplicates
  end

end
