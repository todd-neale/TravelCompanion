class AddCurrencyAndRateToCurrencyData < ActiveRecord::Migration[7.0]
  def change
    add_column :currency_data, :currency, :string
    add_column :currency_data, :rate, :float
  end
end
