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
      if !transactions_array
        transactions_array = []
      end
      transactions_array.push(transaction)
      # updating the hash with the new value in the array
      transactions_by_amount[amount] = transactions_array
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
          transaction.transaction do
            transaction.save!
          end
        end
        pending_transaction
      else
        transactions_per_amount.first
      end
    end
  end

  # filter by country goes first so i can check the duplicates after
  def self.verify_country
    pending_transactions = self.pending
    remaining_pending_transactions = []
    pending_transactions.each do |transaction|
      if transaction.country != "USA"
        transaction.state = "flag"
        transaction.save!
      else
        remaining_pending_transactions << transaction
      end
    end
    # need to convert a simple arrray into an active record relation
    Transaction.where(id: remaining_pending_transactions.map(&:id))
  end

  def self.verify_pending_transactions
    ActiveRecord::Base.transaction do
      self.verify_country
          .check_duplicates
    end
  end
end
