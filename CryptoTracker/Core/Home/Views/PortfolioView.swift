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
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    CoinLogoList(selectedCoin: $selectedCoin, allCoins: viewModel.allCoins)
                    
                    if let coin = selectedCoin {
                        PortfolioInputSection(quantityText: $quantityText, selectedCoin: coin)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton(selectedCoin: $selectedCoin, showCheckmark: $showCheckmark, quantityText: $quantityText)
                    .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
                }
                .sharedBackgroundVisibility(selectedCoin != nil ? .visible : .hidden)
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
    @Binding var selectedCoin: Coin?
    let allCoins: [Coin]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(allCoins) { coin in
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
    @Binding var quantityText: String
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
                
                TextField("Ex: 1.4", text: $quantityText)
                    .frame(width: 80)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .onChange(of: quantityText) { oldValue, newValue in
                        quantityText = String(quantityText.prefix(5))
                    }
            }
            
            Divider()
            
            HStack {
                Text("Current Value :")
                
                Spacer()
                
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding(.top, 20)
        .padding()
        .bold()
        .foregroundStyle(Color.theme.accent)
    }
    
    func getCurrentValue() -> Double {
        guard let quantity = Double(quantityText) else { return 0.0 }
        
        return selectedCoin.currentPrice * quantity
    }
}

private struct SaveButton: View {
    @Binding var selectedCoin: Coin?
    @Binding var showCheckmark: Bool
    @Binding var quantityText: String
    
    var body: some View {
        Button {
            Task {
                await saveButtonPressed()
            }
        } label: {
            HStack(spacing: 10) {
                if showCheckmark {
                    Image(systemName: "checkmark")
                } else {
                    Text("Save".uppercased())
                }
            }
        }
        .padding()
    }
    
    func saveButtonPressed() async {
        guard selectedCoin != nil else { return }
        
        showCheckmark = true
        UIApplication.shared.endEditing()
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        showCheckmark = false
        removeSelectedCoin()
    }
    
    func removeSelectedCoin() {
        selectedCoin = nil
        quantityText = ""
    }
}
