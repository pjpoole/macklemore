class CreateSplits < ActiveRecord::Migration
  def change
    create_table :splits do |t|
      t.integer     :category_id
      t.decimal     :amount,      null: false
      t.string      :memo,        null: false

      t.timestamps                null: false
    end
  end
end
