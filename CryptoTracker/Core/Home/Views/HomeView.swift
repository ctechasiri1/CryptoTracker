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
    @State private var showPortfolioSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSheet) {
                    PortfolioView()
                }

            VStack {
                CustomNavigationHeader(showPorfolio: $showPortfolio, showPortfolioSheet: $showPortfolioSheet)
                
                HomeStatisticView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                ListTitle(showPortfolio: $showPortfolio)
                
                if !showPortfolio {
                    AllCoinsList(allCoins: viewModel.filterdCoins(searchText: viewModel.searchText)) {
                        viewModel.fetchAllData()
                    }
                    .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    PortfolioCoinsList(portfolioCoins: viewModel.portfolioCoins)
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
            .task {
                await viewModel.fetchCoins()
                await viewModel.fetchMarketData()
            }
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
    @Binding var showPortfolioSheet: Bool
    
    var body: some View {
        HStack {
            Button {
                if showPorfolio {
                    showPortfolioSheet.toggle()
                }
            } label: {
                CircleButtonView(imageName: showPorfolio ? "plus" : "info")
                    .background(
                        CircleButtonAnimationView(animate: showPorfolio)
                    )
            }
            
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
    let allCoins: [Coin]
    var reload: () -> Void
    
    var body: some View {
        List {
            ForEach(allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            reload()
        }
    }
}

// MARK: Portfolio Coins List
private struct PortfolioCoinsList: View {
    let portfolioCoins: [Coin]
    
    var body: some View {
        List {
            ForEach(portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }
        }
        .listStyle(PlainListStyle())
    }
}

