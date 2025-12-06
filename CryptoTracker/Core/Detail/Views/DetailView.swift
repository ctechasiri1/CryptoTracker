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
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 100)
                
                OverviewSection(spacing: spacing, columns: columns, overviewStatistics: viewModel.overviewStatistics)
                
                AddtionalDetailsSection(spacing: spacing, columns: columns, additionalDetailsStatistics: viewModel.additionalStatistics)
            }
        }
        .navigationTitle(coin.name)
        .task {
            await viewModel.fetchDetails(coin: coin)
        }
    }
}

#Preview {
    DetailView(coin: Coin.mockCoin)
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
