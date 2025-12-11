//
//  ChartsView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/7/25.
//

import Charts
import SwiftUI

struct ChartsView: View {
    let coin: Coin
    let priceCoordinates: [Double]
    
    @State private var visibleData: [Double] = []
    private let minPrice: Double
    private let maxPrice: Double
    
    init(coin: Coin, priceCoordinates: [Double]) {
        self.coin = coin
        self.priceCoordinates = priceCoordinates
        self.minPrice = self.priceCoordinates.min() ?? 0
        self.maxPrice = self.priceCoordinates.max() ?? 100
    }
    
    var body: some View {
        Chart {
            ForEach(Array(visibleData.enumerated()), id: \.offset) { index, price in
                LineMark(x: .value("Index", index), y: .value("Price", priceCoordinates[index]))
                    .foregroundStyle(coin.priceChangePercentage24H ?? 0 > 0 ? Color.theme.green : Color.theme.red)
                    .offset(x: 10)
            }
        }
        .onAppear {
                for (index, dataPoint) in priceCoordinates.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.02) { // 0.2 second delay per point
                        withAnimation(.easeOut(duration: 0.04)) { // Animate the addition
                            visibleData.append(dataPoint)
                        }
                    }
                }
            }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel {
                    if let value = value.as(Double.self) {
                        Text(value.formatted(.number.notation(.compactName)))
                    }
                }
            }
        }
        .chartYScale(domain: minPrice...maxPrice)
        .frame(height: 200)
        .padding()
        
    }
}

#Preview {
    ChartsView(coin: Coin.mockCoin, priceCoordinates: Coin.mockCoin.sparklineIn7D?.price ?? [])
}
