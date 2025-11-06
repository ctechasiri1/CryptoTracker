//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import ConfidentialKit
import Foundation
import UIKit

final class CoinDataService {
    private let urlString =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=smart-contract-platform&price_change_percentage=24h&include_tokens=top&order=market_cap_desc&per_page=250&page=1&sparkline=true&precision=2" + "?x_cg_demo_api_key=" + "\(Secrets.CoinGeckoAPIKey)"
    
    func getCoinsFromURL() async throws -> [Coin] {
        do {
            let coinsData = try await NetworkingManager.downloadFromURL(urlString: urlString)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode([Coin].self, from: coinsData)
            
            return decodedData
        } catch {
            throw NetworkingError.cannotDecodeContentData
        }
    }
}
