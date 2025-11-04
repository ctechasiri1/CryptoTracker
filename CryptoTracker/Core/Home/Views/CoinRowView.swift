//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            InfoColumn(coin: coin)
            
            Spacer()
            
            if showHoldingsColumn {
                HoldingsColumn(coin: coin)
            }
            
            PriceColumn(coin: coin)
        }
        .font(.subheadline)
    }
}

#Preview {
    CoinRowView(coin: Coin.mockCoin, showHoldingsColumn: true)
}

// MARK: Info Column
private struct InfoColumn: View {
    let coin: Coin
    
    var body: some View {
        Text("\(coin.rank())")
            .font(.caption)
            .foregroundStyle(Color.theme.secondaryText)
            .frame(minWidth: 30)
        
        Circle()
            .frame(width: 30, height: 30)
        
        Text(coin.symbol.uppercased())
            .font(.headline)
            .padding(.leading, 6)
            .foregroundStyle(Color.theme.accent)
    }
}

// MARK: Holdings Column
private struct HoldingsColumn: View {
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue().asCurrencyWith2Decimals())
                .bold()
            
            Text(coin.currentHoldings?.asNumberString() ?? "0.0")
        }
        .foregroundStyle(Color.theme.accent)
    }
}

// MARK: Price Column
private struct PriceColumn: View {
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
