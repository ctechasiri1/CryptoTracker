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
    @Published var portfolioCoins = [Coin]()
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
//        $portfolioCoins
//            .sink { newPortfolioCoins in
//                for coin in newPortfolioCoins {
//                    
//                }
//            }
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, portfolioEntities) -> [Coin] in
                coins
                    .compactMap { (coin) -> Coin? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
