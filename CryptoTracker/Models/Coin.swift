//
//  Coin.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Foundation

// MARK: API Response Example
/*
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
 "current_price": 106915.93,
 "market_cap": 2132592963431,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 2132592963431,
 "total_volume": 74219653168,
 "high_24h": 110665,
 "low_24h": 105540,
 "price_change_24h": -3069.850553838245,
 "price_change_percentage_24h": -2.79113,
 "market_cap_change_24h": -62448957100.62402,
 "market_cap_change_percentage_24h": -2.845,
 "circulating_supply": 19944025,
 "total_supply": 19944025,
 "max_supply": 21000000,
 "ath": 126080,
 "ath_change_percentage": -15.25408,
 "ath_date": "2025-10-06T18:57:42.558Z",
 "atl": 67.81,
 "atl_change_percentage": 157471.35778,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "roi": null,
 "last_updated": "2025-11-03T21:57:32.813Z",
 "sparkline_in_7d": {
 "price": [...]
 },
 "price_change_percentage_24h_in_currency": -2.79113403574148
 }
*/

// MARK: Coin Model
struct Coin: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    func updateHoldings(amount: Double) -> Coin {
        Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    func currentHoldingsValue() -> Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    func rank() -> Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: SparklineIn7D Model
struct SparklineIn7D: Codable {
    let price: [Double]?
}

extension Coin {
    static var mockCoin: Coin {
        Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 106915.93,
            marketCap: 2132592963431,
            marketCapRank: 1,
            fullyDilutedValuation: 2132592963431,
            totalVolume: 74219653168,
            high24H: 110665,
            low24H: 105540,
            priceChange24H: -3069.850553838245,
            priceChangePercentage24H: -2.79113,
            marketCapChange24H: -62448957100.62402,
            marketCapChangePercentage24H: -2.845,
            circulatingSupply: 19944025,
            totalSupply: 19944025,
            maxSupply: 21000000,
            ath: 126080,
            athChangePercentage: -15.25408,
            athDate: "2025-10-06T18:57:42.558Z",
            atl: 67.81,
            atlChangePercentage: 157471.35778,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2025-11-03T21:57:32.813Z",
            sparklineIn7D: SparklineIn7D.init(price: [
                115625.97153429297,
                115351.62818111318,
                114851.0039675739,
                114556.78780221104,
                114483.57892379885,
                114083.62215827091,
                114182.79442806762,
                114007.46090415215,
                114432.66116338983,
                113915.6145651774,
                113893.59661408314,
                114014.14638386737,
                113598.84106730104,
                114167.25192120054,
                114180.58925285893,
                114409.44738110699,
                114517.38704647879,
                114582.85223859442,
                114330.19264699018,
                114579.63972598457,
                115370.86317531622,
                115047.92316979246,
                114680.98349398134,
                115432.20899391148,
                115390.24148231091,
                114879.04201216743,
                113794.77088444383,
                112848.07396975305,
                112996.28547098102,
                113215.0370549014,
                112950.34863259472,
                112619.43698929879,
                112442.13048264038,
                112661.34220587023,
                112553.70991070892,
                112807.01104719764,
                113053.19741122347,
                113314.76255765892,
                113559.64323800545,
                113068.464139051,
                113004.85818477189,
                112901.12769806414,
                113128.77700040374,
                113208.25405094813,
                112936.90520098753,
                112462.75028238822,
                111501.30810115003,
                111227.7335586805,
                111896.91803955882,
                111126.90411123922,
                110741.00143005645,
                111491.36658136133,
                111617.67472874184,
                111207.3808796623,
                110046.66925837283,
                110317.09722878615,
                110669.5906561477,
                110896.71279230528,
                110694.92533758724,
                108604.31193374432,
                110348.8065936701,
                110931.4439411162,
                111315.3215247364,
                110762.13324946298,
                110278.97570288778,
                110096.7126707476,
                109790.13078494355,
                108331.49088121804,
                107908.8997821788,
                108244.98214482478,
                107633.23250565244,
                108008.58442649327,
                107418.2317332118,
                106985.72578963387,
                106786.29956059155,
                107569.21621221502,
                107854.90572441464,
                107811.51124016618,
                108240.76528725718,
                109387.53298510259,
                109637.17189106879,
                108900.12911986955,
                109143.784374306,
                110066.99802604332,
                109832.92592530162,
                109616.79036666283,
                109368.86824190164,
                109953.24259567405,
                109825.51298072185,
                109827.01230324224,
                110325.2676562982,
                109710.11918384078,
                110063.44098949703,
                110588.71583789948,
                110323.49114110022,
                109076.4948704497,
                109260.98083560332,
                109297.6374691829,
                109935.67395777338,
                109423.68231965421,
                109554.25982985727,
                109571.26180211104,
                109573.90555629115,
                109633.20394742656,
                109717.24113095991,
                109737.30627746301,
                110082.93634309991,
                110129.12247259208,
                110124.53504506861,
                109931.10405282541,
                110017.09767500978,
                110159.76614442114,
                109919.60407942254,
                110109.54311950356,
                110082.74373849711,
                109985.33850776782,
                109909.42379420102,
                109850.43699837709,
                110123.15150840105,
                110433.81730690403,
                110211.91277441476,
                110328.64617927653,
                110277.9913786109,
                110387.56264844722,
                110015.89644154096,
                110026.69447298996,
                110066.94174051797,
                109932.61994701959,
                109953.55798231489,
                109967.13702875398,
                110006.75161801101,
                110505.72505906872,
                110444.5484553532,
                110658.13518089944,
                110883.20944824758,
                110778.32348894267,
                110596.23194748371,
                110391.52172986242,
                111057.64793364429,
                110688.82532962412,
                110481.94435751066,
                110372.81685863339,
                110211.2339874412,
                110052.69360433816,
                110076.2963719595,
                110290.60648211652,
                110153.50675474871,
                110059.12871605546,
                110024.17454330286,
                109715.8643029032,
                110650.2092823146,
                110018.317867804,
                109635.30840416232,
                108986.50138920068,
                107960.96906385706,
                107936.88490722963,
                107571.49051149774,
                107421.10889005783,
                107533.41546387474,
                107485.27763737425,
                107098.27941759853,
                107221.82336402568,
                107778.50595672156,
                107819.07564597504,
                107993.55839394528,
                108030.11548756582,
                105802.32388987354,
                106575.48692061796
            ]),
            priceChangePercentage24HInCurrency: -2.79113403574148,
            currentHoldings: 1.5
        )
    }
}
