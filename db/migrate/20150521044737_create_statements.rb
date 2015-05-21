class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.references :account,  index: true, foreign_key: true
      t.date       :start_date
      t.date       :end_date

      t.timestamps            null: false
    end
  end
end
