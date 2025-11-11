//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import Foundation
import UIKit

final class CoinDataService {
    private let urlPath =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=smart-contract-platform&price_change_percentage=24h&include_tokens=top&order=market_cap_desc&per_page=250&page=1&sparkline=true&precision=2"
    
    func getCoinsFromURL() async throws -> [Coin] {
        let apiPathWithKey = urlPath + "?x_cg_demo_api_key=" + "\(Secrets.coinGeckoAPIKey)"
        
        do {
            let coins: [Coin] = try await NetworkingManager.downloadFromURL(urlString: apiPathWithKey)
            
            return coins
        } catch {
            throw error
        }
    }
}
