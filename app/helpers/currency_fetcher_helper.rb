module CurrencyFetcherHelper
  def self.fetch_data
    response = HTTParty.get("https://api.freecurrencyapi.com/v1/latest?apikey=#{ENV['CURRENCY_API_SECRET']}&base_currency=GBP")
    JSON.parse(response.body)['data']
  end
end
