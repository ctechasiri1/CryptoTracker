//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/27/25.
//

import SwiftUI

struct DetailView: View {
    let coin: Coin
    
    var body: some View {
        Text("\(coin.name)")
    }
}

#Preview {
    DetailView(coin: Coin.mockCoin)
}
