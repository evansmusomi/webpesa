class AddTypeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :type, :integer, default: 0
  end
end
