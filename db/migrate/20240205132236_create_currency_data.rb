class CreateCurrencyData < ActiveRecord::Migration[7.0]
  def change
    create_table :currency_data do |t|

      t.timestamps
    end
  end
end
