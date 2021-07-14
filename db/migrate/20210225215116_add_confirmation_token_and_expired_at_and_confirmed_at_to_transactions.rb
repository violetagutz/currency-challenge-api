class AddConfirmationTokenAndExpiredAtAndConfirmedAtToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :confirmation_token, :string
    add_index :transactions, :confirmation_token
    add_column :transactions, :expired_at, :datetime
    add_column :transactions, :confirmed_at, :datetime
  end
end
