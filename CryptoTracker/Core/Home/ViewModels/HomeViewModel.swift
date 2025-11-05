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
    
    private let dataService = CoinDataService()
    
    init() {
        allCoins.append(Coin.mockCoin)
        porfolioCoins.append(Coin.mockCoin)
    }
    
    func fetchCoins() async {
        do {
            let coins = try await dataService.getCoins()
            await MainActor.run {
                self.allCoins = coins
            }
        } catch {
            print("There was a failure calling the API.")
        }
    }
}
