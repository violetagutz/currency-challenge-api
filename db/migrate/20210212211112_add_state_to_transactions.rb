class AddStateToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :state, :integer, default: 0, null: false
    add_index :transactions, :state
  end
end
