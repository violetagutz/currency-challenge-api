class AddCountryToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :country, :string, default: "USA", null:false
  end
end
