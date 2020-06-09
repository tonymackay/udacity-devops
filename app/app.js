const express = require('express')
const yahoo = require('yahoo-finance');
const app = express()
const port = 8080;

app.get('/quote', async (req, res, fail) => {
    var response = []
    const symbol = req.query.symbol;

    if (typeof symbol === 'undefined') {
        res.statusCode = 404
        return res.json(response)
    }

    if (Array.isArray(symbol)) {
        symbol.forEach(element => response.push({
            symbol: element.toUpperCase(),
            price: 0,
            previousPrice: 0,
            currency: ''
        }))
    } else {
        response.push({
            symbol: symbol.toUpperCase(),
            price: 0,
            previousPrice: 0,
            currency: ''
        })
    }
    // query yahoo api
    try {
        if (response.length == 1) {
            const result = await yahoo.quote(symbol);
            parseResult(result, response)
        } else if (response.length > 1) {
            const symbols = {
                "symbols": response.map(a => a.symbol)
            }
            const result = await yahoo.quote(symbols)
            parseResult(result, response)
        }
    } catch (error) {
        response.forEach(element => {
            if (error.message.indexOf(element.symbol) !== -1) {
                const errorResponse = {
                    symbol: element.symbol,
                    message: 'Quote not found for ticker symbol: ' + element.symbol
                }
                res.statusCode = 400
                response = errorResponse
            }
        })
    }
    return res.json(response)
})

function parseResult(result, response) {
    response.forEach(element => {
        if (result[element.symbol]) {
            element.price = result[element.symbol].price.regularMarketPrice
            element.previousPrice = result[element.symbol].price.regularMarketPreviousClose
            element.currency = result[element.symbol].price.currency
        } else if (result.price) {
            element.price = result.price.regularMarketPrice
            element.previousPrice = result.price.regularMarketPreviousClose
            element.currency = result.price.currency
        }
    })
}

app.listen(port, () => console.log(`Listening at http://localhost:${port}`))