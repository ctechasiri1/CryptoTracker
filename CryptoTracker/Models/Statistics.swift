//
//  Statistics.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/7/25.
//

import Foundation

struct Statistics: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentChange: Double?
    let portfolioValue: Double?
    
    init(title: String, value: String, percentChange: Double? = nil, portfolioValue: Double? = 0.0) {
        self.title = title
        self.value = value
        self.percentChange = percentChange
        self.portfolioValue = portfolioValue
    }
}

extension Statistics {
    static var mockMarketCap: Statistics {
        Statistics(title: "Market Cap", value: "$12.5Bn", percentChange: 25.34)
    }
    
    static var mockTotalVolume: Statistics {
        Statistics(title: "Total Volume", value: "$1.23Trillion")
    }
    
    static var mockPortfolioValue: Statistics {
        Statistics(title: "Portfolio Value", value: "$50.4K", percentChange: 12.53)
    }
}
