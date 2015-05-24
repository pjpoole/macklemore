class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :account_users do |t|
      t.integer     :user_id,     null: false
      t.integer     :account_id,  null: false

      t.timestamps                null: false
    end

    add_index :account_users, :user_id
    add_index :account_users, :account_id
  end
end
