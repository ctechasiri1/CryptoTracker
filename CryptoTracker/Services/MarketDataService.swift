//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/10/25.
//

import Foundation
import UIKit

final class MarketDataService {
    func getMarketDataFromURL() async throws -> MarketData {
        let urlPath: String = "https://api.coingecko.com/api/v3/global"
        let apiPathWithKey = urlPath + "?x_cg_demo_api_key=" + "\(Secrets.coinGeckoAPIKey)"
        
        do {
            let global: GlobalMarketData = try await NetworkingManager.downloadFromURL(urlString: apiPathWithKey)
            
            guard let marketData = global.data else { throw NetworkingError.cannotDecodeContentData }
            
            return marketData
        } catch {
            throw error 
        }
    }
}
