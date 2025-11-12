//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/11/25.
//

import SwiftUI

struct CoinImageView: View {
    let coin: Coin
    
    var body: some View {
        VStack {
            CachedAsyncImage(url: URL(string: coin.image)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinImageView(coin: Coin.mockCoin)
}
