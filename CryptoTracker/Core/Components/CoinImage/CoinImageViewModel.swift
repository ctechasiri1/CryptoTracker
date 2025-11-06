//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import Combine
import Foundation
import UIKit

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let dataService: CoinImageService
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(imageString: coin.image)
    }
}
