class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.date :happened_on
      t.string :code

      t.timestamps null: false
    end

    add_reference :transactions, :sender, references: :users, index: true
    add_foreign_key :transactions, :users, column: :sender_id

    add_reference :transactions, :recipient, references: :users, index: true
    add_foreign_key :transactions, :users, column: :recipient_id
  end
end
