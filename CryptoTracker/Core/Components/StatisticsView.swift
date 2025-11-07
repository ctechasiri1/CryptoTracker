//
//  StatisticsView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/7/25.
//

import SwiftUI

struct StatisticsView: View {
    let stat: Statistics
    
    var body: some View {
        VStack(spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentChange ?? 0) >= 0 ? 0 : 180)
                    )
                
                Text(stat.percentChange?.asPercentString() ?? "")
                    .font(.system(.caption, weight: .bold))
            }
            .foregroundStyle((stat.percentChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    StatisticsView(stat: Statistics.mockTotalVolume)
}
