//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        TextField("Search by name or symbol...", text: $viewModel.searchText)
            .padding(.horizontal, 50)
            .frame(height: 50)
            .background(Color.theme.background)
            .clipShape(Capsule())
            .shadow(color: Color.theme.accent.opacity(0.5), radius: 15, x: 0, y: 0)
            .overlay(
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.theme.secondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            )
            .padding()
    }
}

#Preview {
    SearchBarView()
        .environmentObject(HomeViewModel())
}
