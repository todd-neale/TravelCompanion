class AddCurrentToCurrencyData < ActiveRecord::Migration[7.0]
  def change
    add_column :currency_data, :current, :boolean, default: false
  end
end
