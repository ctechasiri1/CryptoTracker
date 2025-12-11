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
    @State private var showSettingsSheet: Bool = false
    
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: Coin? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showPortfolioSheet) {
                        PortfolioView()
                    }
                    .sheet(isPresented: $showSettingsSheet) {
                        SettingsView()
                    }
                
                VStack {
                    CustomNavigationHeader(showPorfolio: $showPortfolio, showPortfolioSheet: $showPortfolioSheet, showSettingsSheet: $showSettingsSheet)
                    
                    HomeStatisticView(showPortfolio: $showPortfolio)
                    
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    ListTitle(sortOption: $viewModel.sortOption, showPortfolio: $showPortfolio)
                    
                    if !showPortfolio {
                        AllCoinsList(showDetailView: $showDetailView, selectedCoin: $selectedCoin, allCoins: viewModel.filterdCoins(searchText: viewModel.searchText)) {
                            viewModel.fetchAllData()
                        }
                        .navigationDestination(isPresented: $showDetailView) {
                            if let coin = selectedCoin {
                                DetailView(coin: coin)
                            }
                        }
                        .transition(.move(edge: .leading))
                    }
                    
                    if showPortfolio {
                        ZStack(alignment: .center) {
                            if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                                Text("Click the (+) button to add some coins")
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.theme.secondaryText)
                                    .font(.system(.callout, weight: .medium))
                                    .padding(50)
                            } else {
                                PortfolioCoinsList(showDetailsView: $showDetailView, portfolioCoins: viewModel.portfolioCoins)
                            }
                        }
                        .transition(.move(edge: .trailing))
                    }
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.fetchCoins()
            await viewModel.fetchMarketData()
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
    @Binding var showSettingsSheet: Bool
    
    var body: some View {
        HStack {
            Button {
                if showPorfolio {
                    showPortfolioSheet.toggle()
                } else {
                    showSettingsSheet.toggle()
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
    @Binding var sortOption: SortOptions
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            Button {
                sortOption = (sortOption == .rankAscending ? .rankDescending : .rankAscending)
            } label: {
                HStack {
                    Text("Coin")
                    Image(systemName: "chevron.down")
                        .opacity((sortOption == .rankAscending || sortOption == .rankDescending) ? 1 : 0)
                        .rotationEffect(sortOption == .rankAscending ? .degrees(0) : .degrees(180))
                }
            }
            
            Spacer()
            
            if showPortfolio {
                Button {
                    sortOption = (sortOption == .holdingsAscending ? .holdingsDescending : .holdingsAscending)
                } label: {
                    HStack {
                        Text("Holdings")
                        Image(systemName: "chevron.down")
                            .opacity((sortOption == .holdingsAscending || sortOption == .holdingsDescending) ? 1 : 0)
                            .rotationEffect(sortOption == .holdingsAscending ? .degrees(0) : .degrees(180))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 3, alignment: .leading)
                }
                .transition(.scale)
            }
            
            Button {
                sortOption = (sortOption == .priceAscending ? .priceDescending : .priceAscending)
            } label: {
                HStack {
                    Text("Price")
                    Image(systemName: "chevron.down")
                        .opacity((sortOption == .priceAscending || sortOption == .priceDescending) ? 1 : 0)
                        .rotationEffect(sortOption == .priceAscending ? .degrees(0) : .degrees(180))
                }
                .frame(width: UIScreen.main.bounds.width / 4.5, alignment: .leading)
            }
        }
        .padding(.horizontal)
        .foregroundStyle(Color.theme.secondaryText)
        .font(.caption)
    }
}

// MARK: All Coins List
private struct AllCoinsList: View {
    @Binding var showDetailView: Bool
    @Binding var selectedCoin: Coin?
    let allCoins: [Coin]
    var reload: () -> Void
    
    var body: some View {
        List {
            ForEach(allCoins) { coin in
                Button {
                    showDetailView.toggle()
                    selectedCoin = coin
                } label: {
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                }
                .listRowBackground(Color.theme.background)
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
    @Binding var showDetailsView: Bool
    let portfolioCoins: [Coin]
    
    var body: some View {
        List {
            ForEach(portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowBackground(Color.theme.background)
            }
        }
        .listStyle(PlainListStyle())
    }
}

