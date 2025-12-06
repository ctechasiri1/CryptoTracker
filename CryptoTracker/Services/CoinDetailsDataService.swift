//
//  CoinDetailsDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/5/25.
//

import Combine
import Foundation

final class CoinDetailsDataService {
    func getCoinDetailsFromURL(coin: Coin) async throws -> CoinDetails {
        let urlPath =  "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&include_categories_details=false"
        let apiPathWithKey = urlPath + "?x_cg_demo_api_key=" + "\(Secrets.coinGeckoAPIKey)"
        
        do {
            let coinDetails: CoinDetails = try await NetworkingManager.downloadFromURL(urlString: apiPathWithKey)

            return coinDetails
        } catch {
            throw error
        }
    }
}
