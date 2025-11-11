//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/10/25.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hi")
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
