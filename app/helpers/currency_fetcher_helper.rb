module CurrencyFetcherHelper
  def self.fetch_data
    response = HTTParty.get('https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_UwKARtY2GzNijOPGIBnWM6ox6Uv9U78cQrOCa6fT&base_currency=GBP')
    JSON.parse(response.body)['data']
  end
end
