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
}
