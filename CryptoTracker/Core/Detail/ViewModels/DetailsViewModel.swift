//
//  DetailsViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/5/25.
//

import Combine
import Foundation

class DetailsViewModel: ObservableObject {
    @Published var expandDescription: Bool = false
    @Published var coinDetails: CoinDetails? = nil
    @Published var overviewStatistics: [Statistics] = []
    @Published var additionalStatistics: [Statistics] = []
    private let coinDetailDataService: CoinDetailsDataService = CoinDetailsDataService()
    
    func fetchDetails(coin: Coin) async {
        do {
            let loadedCoinDetails = try await coinDetailDataService.getCoinDetailsFromURL(coin: coin)
            await MainActor.run {
                self.coinDetails = loadedCoinDetails
                
                // All Statistics for Overview
                let price = coin.currentPrice.asCurrencyWith2Decimals()
                let pricePercentChange = coin.priceChangePercentage24H
                let priceStat = Statistics(title: "Current Price", value: price, percentChange: pricePercentChange)
                
                let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange = coin.marketCapChangePercentage24H
                let marketCapStat = Statistics(title: "Market Capitalization", value: marketCap, percentChange: marketCapPercentChange)
                
                let rank = "\(coin.rank())"
                let rankStat = Statistics(title: "Rank", value: rank)
                
                let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = Statistics(title: "Total Volume (24h)", value: volume)
                
                self.overviewStatistics = [priceStat, marketCapStat, rankStat, volumeStat]
                
                // All Statistics for Additional
                
                let high = coin.high24H?.asCurrencyWith6Decimals() ?? "N/A"
                let highStat = Statistics(title: "24h High", value: high)
                
                let low = coin.low24H?.asCurrencyWith6Decimals() ?? "N/A"
                let lowStat = Statistics(title: "24h Low", value: low)
                
                let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "N/A"
                let priceChangeStat = Statistics(title: "24h Price Change", value: priceChange, percentChange: pricePercentChange)
                
                let marketCapChange = coin.marketCapChange24H?.formattedWithAbbreviations() ?? ""
                let marketCapPercentChangeStat = Statistics(title: "24h Market Cap Change", value: marketCapChange, percentChange: marketCapPercentChange)
                
                self.additionalStatistics = [highStat, lowStat, priceChangeStat, marketCapPercentChangeStat]
            }
        } catch {
            print(error)
        }
    }
}
