//
//  Coin.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Foundation

// MARK: API Response Example
/*
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price": 106915.93,
 "market_cap": 2132592963431,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 2132592963431,
 "total_volume": 74219653168,
 "high_24h": 110665,
 "low_24h": 105540,
 "price_change_24h": -3069.850553838245,
 "price_change_percentage_24h": -2.79113,
 "market_cap_change_24h": -62448957100.62402,
 "market_cap_change_percentage_24h": -2.845,
 "circulating_supply": 19944025,
 "total_supply": 19944025,
 "max_supply": 21000000,
 "ath": 126080,
 "ath_change_percentage": -15.25408,
 "ath_date": "2025-10-06T18:57:42.558Z",
 "atl": 67.81,
 "atl_change_percentage": 157471.35778,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2025-11-03T21:57:32.813Z",
 "sparkline_in_7d": {
 "price": [...]
 },
 "price_change_percentage_24h_in_currency": -2.79113403574148
 }
*/

// MARK: Coin Model
struct Coin: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    func updateHoldings(amount: Double) -> Coin {
        Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    func currentHoldingsValue() -> Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    func rank() -> Int {
        return Int(marketCap ?? 0)
    }
}

// MARK: SparklineIn7D Model
struct SparklineIn7D: Codable {
    let price: [Double]?
}
