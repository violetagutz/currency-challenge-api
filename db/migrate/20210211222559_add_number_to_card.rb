class AddNumberToCard < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :number, :integer
    add_index :cards, :number
  end
end
