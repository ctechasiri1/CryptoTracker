//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/10/25.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quanityText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    CoinLogoList(selectedCoin: $selectedCoin)
                    
                    if let coin = selectedCoin {
                        PortfolioInputSection(quanityText: $quanityText, selectedCoin: coin)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
            .navigationTitle("Edit Portfolio")
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}

private struct CoinLogoList: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var selectedCoin: Coin?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinImageView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
                        )
                }
            }
        }
        .padding(.vertical, 4)
        .padding(.leading)
    }
}

private struct PortfolioInputSection: View {
    @Binding var quanityText: String
    let selectedCoin: Coin
    
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                Text("Current Price of \(selectedCoin.symbol.uppercased()):")
                
                Spacer()
                
                Text("\(selectedCoin.currentPrice.asCurrencyWith6Decimals())")
            }
            
            Divider()
            
            HStack {
                Text("Amount in your portfolio:")
                
                Spacer()
                
                TextField("Ex: 1.4", text: $quanityText)
                    .frame(width: 80)
            }
            
            Divider()
            
            HStack {
                Text("Current Value :")
                
                Spacer()
                
                Text("\(selectedCoin.currentPrice.asCurrencyWith6Decimals())")
            }
        }
        .padding(.top, 20)
        .padding()
        .bold()
        .foregroundStyle(Color.theme.accent)
    }
}

