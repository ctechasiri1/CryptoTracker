//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import ConfidentialKit
import Foundation

final class CoinDataService {
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&category=smart-contract-platform&price_change_percentage=24h&include_tokens=top&order=market_cap_desc&per_page=250&page=1&sparkline=true&precision=2"
    
    func getCoins() async throws -> [Coin] {
        guard let url = URL(string: urlString + "?x_cg_demo_api_key=" + "\(Secrets.CoinGeckoAPIKey)") else { throw NetworkingError.badURL }
        
        do {
            let result = try await NetworkingManager.download(url: url)
            
            try NetworkingManager.handleURLResponse(urlResponse: result.response)
        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode([Coin].self, from: result.data)
            
            return decodedData
        } catch {
            throw NetworkingError.cannotDecodeContentData
        }
    }
    
//    func getImages() async throws -> [Image] {
//        
//    }
}
