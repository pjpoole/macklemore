class AddIndicesToTables < ActiveRecord::Migration
  def change
    add_index :categories, :group_id
    add_index :splits, :category_id
    add_index :transactions, :account_id
  end
end
