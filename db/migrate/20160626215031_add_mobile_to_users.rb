class AddMobileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string
    add_index :users, :mobile, unique: true
  end
end
