class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date        :date,        null: false
      t.integer     :account_id,  null: false
      t.string      :reference

      t.timestamps                null: false
    end
  end
end
