//
//  HomeStatisticView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/10/25.
//

import SwiftUI

struct HomeStatisticView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(viewModel.statsList) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatisticView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
