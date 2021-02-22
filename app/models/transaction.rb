class Transaction < ApplicationRecord

  belongs_to :card, dependent: :destroy

  validates :amount, :card_id, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  enum state: { "pending": 0, "declined": 1, "flag": 2 }

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

    # map dont uses return, just return the last thing
    # check if what i am returning is the same type: hash, record, arr
    # .keys returns an array of keys of that hash
    transactions_by_amount.keys.map do |transactions_amount|

      transactions_per_amount = transactions_by_amount[transactions_amount]

      if transactions_per_amount.length > 1
        pending_transaction = transactions_per_amount.shift
        transactions_per_amount.each do |transaction|
          transaction.state = "declined"
          transaction.save
        end
        pending_transaction
      else
        pending_transaction = transactions_per_amount.first
      end
    end
  end

  def self.verify_country
    pending_transactions = self.check_duplicates
    pending_transactions.map do |transaction|
      if transaction.country != "USA"
        transaction.state = "flag"
        transaction.save
      end
      transaction
    end
  end

  def self.verify_pending_transactions
    self.verify_country
  end
end
