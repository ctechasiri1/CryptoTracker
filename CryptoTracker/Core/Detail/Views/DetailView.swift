//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/27/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = DetailsViewModel()
    let coin: Coin
    private let columns: [GridItem] = [GridItem(.flexible(minimum: 100)), GridItem(.flexible(minimum: 100))]
    private let spacing: CGFloat = 30
    
    var body: some View {
        ScrollView {
            VStack {
                StatsSection(coin: coin)
                
                ChartsView(coin: coin, priceCoordinates: coin.sparklineIn7D?.price ?? [])
                
                OverviewSection(spacing: spacing, columns: columns, overviewStatistics: viewModel.overviewStatistics)
                
                AddtionalDetailsSection(spacing: spacing, columns: columns, additionalDetailsStatistics: viewModel.additionalStatistics)
            }
        }
        .navigationTitle(coin.name)
        .task {
            await viewModel.fetchDetails(coin: coin)
        }
        .toolbar {
            ToolbarItem {
                ToolBarItem(coin: coin)
            }
        }
    }
}

#Preview {
    DetailView(coin: Coin.mockCoin)
}

struct StatsSection: View {
    let coin: Coin
    
    var body: some View {
        VStack(spacing: 5) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .font(.system(.title, weight: .bold))
            
            HStack {
                Image(systemName: "triangle.fill")
                    .rotationEffect(coin.priceChangePercentage24H ?? 0 > 0 ? .zero : .degrees(180))
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.00%")

            }
            .font(.system(.caption, weight: .bold))
            .foregroundStyle(coin.priceChangePercentage24H ?? 0 > 0 ? Color.theme.green : Color.theme.red)
        }
    }
}

struct ToolBarItem: View {
    let coin: Coin
    
    var body: some View  {
        HStack {
            CachedAsyncImage(url: URL(string:coin.image)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
                
            Text(coin.symbol.uppercased())
        }
        .padding()
    }
}

struct OverviewSection: View {
    let spacing: CGFloat
    let columns: [GridItem]
    let overviewStatistics: [Statistics]
    
    var body: some View {
        Text("Overview")
            .font(.system(.title, weight: .bold))
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        Divider()
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
            ForEach(overviewStatistics) { stat in
                StatisticView(stat: stat)
                    .padding(.horizontal)
            }
        }
    }
}

struct AddtionalDetailsSection: View {
    let spacing: CGFloat
    let columns: [GridItem]
    let additionalDetailsStatistics: [Statistics]
    
    var body: some View {
        Text("Additional Details")
            .font(.system(.title, weight: .bold))
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        Divider()
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
            ForEach(additionalDetailsStatistics) { stat in
                StatisticView(stat: stat)
                    .padding(.horizontal)
            }
        }
    }
}
