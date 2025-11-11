//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var statsList = [Statistics]()
    
    @Published var allCoins = [Coin]()
    @Published var porfolioCoins = [Coin]()
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    init() {
        allCoins.append(Coin.mockCoin)
        porfolioCoins.append(Coin.mockCoin)
    }
    
    func fetchCoins() async {
        do {
            let coins = try await coinDataService.getCoinsFromURL()
            await MainActor.run {
                self.allCoins = coins
            }
        } catch {
            print(error)
        }
    }
    
    func fetchMarketData() async {
        do {
            let marketData = try await marketDataService.getMarketDataFromURL()
            
            let marketCap = Statistics(title: "Market Cap", value: marketData.marketCap, percentChange: Double(marketData.marketCapPercentageInBTC))
            let volume = Statistics(title: "24h Volume", value: marketData.volume)
            let btcDominance = Statistics(title: "BTC Dominance", value: marketData.marketCapPercentageInBTC)
            let portfolio = Statistics(title: "Porfolio Value", value: "$0.00", percentChange: 0)
            
            await MainActor.run {
                statsList.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
            }
        } catch {
            print(error)
        }
    }
    
    func clearTextField() {
        searchText = ""
    }
    
    func filterdCoins(searchText: String) -> [Coin] {
        if searchText.isEmpty { return allCoins }
        let filteredCoins = allCoins.filter({ $0.name.localizedCaseInsensitiveContains(searchText) || $0.symbol.localizedCaseInsensitiveContains(searchText) || $0.id.localizedCaseInsensitiveContains(searchText) })
        
        return filteredCoins
    }
}
