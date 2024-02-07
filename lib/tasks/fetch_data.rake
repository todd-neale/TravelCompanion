namespace :app_essentials do
  task fetch_and_store_data: :environment do
    # Fetch data from the external API
    data = CurrencyFetcherHelper.fetch_data

    CurrencyDatum.where(current: true).update_all(current: false)

    data.each do | conversion |
      CurrencyDatum.create(currency: conversion[0], rate: conversion[1], current: true)
    end

    p "Data fetched and stored successfully"
  end
end
