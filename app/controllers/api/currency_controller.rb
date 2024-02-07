module Api
  class CurrencyController < ApplicationController
    def get_data
      data = CurrencyDatum.where(current: true)  # Retrieve the latest stored data

      render json: data
    end

    def symbols
      render json: ('currency-symbols.json')
    end
  end
end
