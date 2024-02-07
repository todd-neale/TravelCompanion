class AddCurrencyAndAmountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :currency_from, :string, default: 'ZAR'
    add_column :users, :currency_to, :string, default: 'GBP'
    add_column :users, :amount, :decimal
  end
end
