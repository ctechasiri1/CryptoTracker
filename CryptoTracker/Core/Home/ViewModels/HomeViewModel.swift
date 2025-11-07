//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins = [Coin]()
    @Published var porfolioCoins = [Coin]()
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    
    init() {
        allCoins.append(Coin.mockCoin)
        porfolioCoins.append(Coin.mockCoin)
    }
    
    func fetchCoins() async {
        do {
            let coins = try await dataService.getCoinsFromURL()
            await MainActor.run {
                self.allCoins = coins
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
