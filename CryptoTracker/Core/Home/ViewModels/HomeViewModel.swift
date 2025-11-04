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
    
    init() {
        allCoins.append(Coin.mockCoin)
        porfolioCoins.append(Coin.mockCoin)
    }
}
