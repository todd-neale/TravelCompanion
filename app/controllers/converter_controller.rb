require 'httparty'


class ConverterController < ApplicationController
  def index
    @user = current_user
    @data = get_data
    @currencies = @data.map(&:currency)
    @currency_from_symbol = "R"
    @currency_to_symbol = "£"
    @updated_on = @data.first.updated_at
  end

  def get_data
    CurrencyDatum.where(current: true)  # Retrieve the latest stored data
  end
end
