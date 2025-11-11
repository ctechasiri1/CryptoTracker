//
//  SecretsDecoder.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/10/25.
//

import Foundation

enum Secrets {
    static var coinGeckoAPIKey: String {
        guard let key = Bundle.main.infoDictionary?["COIN_GECKO_API_KEY"] as? String else {
            fatalError("Coin Gecko API key not found check the Secrets.xcconfig")
        }
        return key
    }
}
