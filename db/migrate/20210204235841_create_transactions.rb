class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :card_id

      t.timestamps
    end
    add_index :transactions, :card_id
  end
end
