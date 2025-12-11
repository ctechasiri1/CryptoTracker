//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Combine
import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    @Published var statsList = [Statistics]()
    
    @Published var allCoins = [Coin]()
    @Published var portfolioCoins = [Coin]()
    @Published var marketData: MarketData? = nil
    
    @Published var searchText: String = ""
    @Published var sortOption: SortOptions = .rankAscending

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        $sortOption
            .map(self.sortCoins)
            .sink { [weak self] sortedCoins in
                if self?.sortOption == .holdingsAscending || self?.sortOption == .holdingsDescending {
                    self?.portfolioCoins = sortedCoins
                } else {
                    self?.allCoins = sortedCoins
                }
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(self.updatePortfolioHoldings)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $portfolioCoins
            .combineLatest($marketData)
            .map(self.updatePortfolioValue)
            .sink { [weak self] stats in
                self?.statsList = stats
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
            await MainActor.run {
                self.marketData = marketData
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAllData() {
        Task {
            await self.fetchCoins()
            await self.fetchMarketData()
            HapticManager.notification(type: .success)
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
    
    private func sortCoins(sortOption: SortOptions) -> [Coin] {
        switch sortOption {
        case .rankAscending:
            return allCoins.sorted(by: {$0.rank() < $1.rank()})
        case .rankDescending:
            return allCoins.sorted(by: {$0.rank() > $1.rank()})
        case .priceAscending:
            return allCoins.sorted(by: {$0.currentPrice > $1.currentPrice})
        case .priceDescending:
            return allCoins.sorted(by: {$0.currentPrice < $1.currentPrice})
        case .holdingsAscending:
            return portfolioCoins.sorted(by: {$0.currentHoldingsValue() > $1.currentHoldingsValue()})
        case .holdingsDescending:
            return portfolioCoins.sorted(by: {$0.currentHoldingsValue() < $1.currentHoldingsValue()})
        }
    }
    
    private func updatePortfolioValue(portfolioCoins: [Coin], marketData: MarketData?) -> [Statistics] {
        let portfolioValue = portfolioCoins
                                .map({$0.currentHoldingsValue()})
                                .reduce(0, +)
        
        let previousValue = portfolioCoins
                                .map { (coin) -> Double in
                                    let currentValue = coin.currentHoldingsValue()
                                    let precentageChanged = (coin.priceChangePercentage24H ?? 0) / 100
                                    let previousValue = currentValue / (1 + precentageChanged)
                                    
                                    return previousValue
                                }
                                .reduce(0, +)
        
        let perecentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        guard let data = marketData else { return [] }
        
        let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistics(title: "24h Volume", value: data.volume)
        let btcDominance = Statistics(title: "BTC Dominance", value: data.marketCapPercentageInBTC)
        let portfolio = Statistics(title: "Porfolio Value", value: "\(portfolioValue.asCurrencyWith2Decimals())", percentChange: perecentageChange)
            
        return [marketCap, volume, btcDominance, portfolio]
    }
    
    private func updatePortfolioHoldings(coins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        coins
            .compactMap { (coin) -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
}
