import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["from", "amount", "to"];
    DATA = this.getData();

    connect() {
        document.querySelector("#user_currency_from").classList.remove("form-select")
        document.querySelector("#user_currency_to").classList.remove("form-select")
        document.querySelector("#user_currency_from").classList.remove("is-valid")
        document.querySelector("#user_currency_to").classList.remove("is-valid")

        this.doTheThing()
    }

    doTheThing() {
        this.convertCurrency();
        this.renderResultToReview();
        this.renderTheFlagAndSymbol();
    }

    renderTheFlagAndSymbol() {
        this.renderSymbolToTheView();
        this.renderFlagToTheView();
        this.doTheThing()
    }

    flipItUp() {
        const from = document.querySelector("#user_currency_from").value;
        document.querySelector("#user_currency_from").value = document.querySelector("#user_currency_to").value;
        document.querySelector("#user_currency_to").value = from;

        this.doTheThing()
    }

    async getData() {
        try {
            const response = await fetch('/api/get_data');
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching data:', error);
            throw error; // You can handle the error accordingly or remove this line if you want to suppress errors.
        }
    }


    convertCurrency() {
        const from = document.querySelector("#user_currency_from").value;
        const to = document.querySelector("#user_currency_to").value;
        const amount = document.querySelector("#user_amount").value;

        return this.DATA.then(result => {
            // Find the currency objects for 'from' and 'to'
            const fromCurrency = result.find(currency => currency.currency === from);
            const toCurrency = result.find(currency => currency.currency === to);

            this.renderExchangeRate(fromCurrency, toCurrency)

            if (!fromCurrency || !toCurrency) {
                console.error('Invalid currency codes');
                return null;
            }

            const amountInBaseCurrency = amount / fromCurrency.rate;
            const convertedAmount = amountInBaseCurrency * toCurrency.rate;

            return convertedAmount.toFixed(2);
        })
    }


    renderResultToReview() {
        this.convertCurrency().then(result => {
            document.querySelector("#result").value = result;
        })
    }

    async renderSymbolToTheView() {
        // go to /currency-symbol.yml to get the symbol from the currency

        const from = document.querySelector("#user_currency_from").value;
        const to = document.querySelector("#user_currency_to").value;

        const symbol = await this.getSymbol(from);
        const toSymbol = await this.getSymbol(to);

        document.querySelector("#from_symbol").innerHTML = symbol;
        document.querySelector("#to_symbol").innerHTML = toSymbol;
    }

    async getSymbol(isoCode) {
        try {
            const result = await this.getSymbolData();

            // Check if result is an array
            if (Array.isArray(result)) {
                const currency = result.find(curr => curr.abbreviation === isoCode);

                // Check if currency is found
                if (currency) {
                    return currency.symbol;
                } else {
                    console.error(`Currency not found for ISO code: ${isoCode}`);
                    return null; // or handle the absence of currency symbol accordingly
                }
            } else {
                console.error('Invalid or empty result from getSymbolData');
                return null; // or handle the absence of currency symbols accordingly
            }
        } catch (error) {
            console.error('Error fetching or processing data:', error);
            throw error; // You can handle the error accordingly or remove this line if you want to suppress errors.
        }
    }

    async getSymbolData() {
        try {
            const response = await fetch('/currency-symbols.json');
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching data:', error);
            throw error; // You can handle the error accordingly or remove this line if you want to suppress errors.
        }
    }

    async getFlag(isoCode) {
        try {
            const result = await this.getSymbolData();

            // Check if result is an array
            if (Array.isArray(result)) {
                const currency = result.find(curr => curr.abbreviation === isoCode);

                // Check if currency is found
                if (currency) {
                    return currency.flag;
                } else {
                    console.error(`Currency not found for ISO code: ${isoCode}`);
                    return null; // or handle the absence of currency symbol accordingly
                }
            } else {
                console.error('Invalid or empty result from getFlagData');
                return null; // or handle the absence of currency symbols accordingly
            }
        } catch (error) {
            console.error('Error fetching or processing data:', error);
            throw error; // You can handle the error accordingly or remove this line if you want to suppress errors.
        }
    }

    async renderFlagToTheView() {
        const from = document.querySelector("#user_currency_from").value;
        const to = document.querySelector("#user_currency_to").value;

        const flag = await this.getFlag(from);
        const toFlag = await this.getFlag(to);

        document.querySelector("#fromflag").src = flag;
        document.querySelector("#toflag").src = toFlag;
    }

    shakeItUp() {
        const h1Element = document.querySelector('.title');
        const animations = ['shaking', 'rotated-shaking', 'slam'];
        const randomAnimation = animations[Math.floor(Math.random() * animations.length)];

        h1Element.classList.add(randomAnimation);

        // Remove the shaking class after the animation completes
        setTimeout(function() {
            h1Element.classList.remove(randomAnimation);
        }, 500);
    }

    renderExchangeRate(from, to) {
        // calculate the exchange rate
        const exchangeRate = to.rate / from.rate;
        document.querySelector("#exchange_rate").innerHTML = `1 ${from.currency} = ${exchangeRate.toFixed(2)} ${to.currency}`;
    }
}