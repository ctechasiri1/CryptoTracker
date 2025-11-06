//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                CustomNavigationHeader(showPorfolio: $showPortfolio)
                
                ListTitle(showPortfolio: $showPortfolio)
                
                SearchBarView()
                
                if !showPortfolio {
                    AllCoinsList()
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    PortfolioCoinsList()
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
//            .task {
//                await viewModel.fetchCoins()
//            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
    .environmentObject(HomeViewModel())
}

// MARK: Navigation Bar
private struct CustomNavigationHeader: View {
    @Binding var showPorfolio: Bool
    
    var body: some View {
        HStack {
            CircleButtonView(imageName: showPorfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: showPorfolio)
                )
            
            Spacer()
            
            Text(showPorfolio ? "Portfolio" : "Live Prices")
                .font(.system(.headline, weight: .heavy))
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(imageName: "chevron.left")
                .rotationEffect(Angle(degrees: showPorfolio ? 180 : 0))
                .animation(.bouncy(duration: 1.5), value: showPorfolio)
                .onTapGesture {
                    withAnimation {
                        showPorfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

// MARK: List Title
private struct ListTitle: View {
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            Text("Coin")
            
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
                    .padding(.leading)
                    .transition(.scale)
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .padding(.horizontal)
        .foregroundStyle(Color.theme.secondaryText)
        .font(.caption)
    }
}

// MARK: All Coins List
private struct AllCoinsList: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: Portfolio Coins List
private struct PortfolioCoinsList: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.porfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }
        }
        .listStyle(PlainListStyle())
    }
}
