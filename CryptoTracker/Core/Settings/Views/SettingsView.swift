//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/8/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    private let defaultURL: String = "https://github.com/chiraphattechasiri/CryptoTracker"
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("COINGECKO") {
                        VStack {
                            Image("coingecko")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            
                            Text("The crytocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed!")
                        }
                        if let url = URL(string: "https://www.coingecko.com") {
                            Link("Visit CoinGecko", destination: url)
                                .foregroundStyle(Color.blue)
                        }
                    }
                    .listRowBackground(Color.theme.background.opacity(0.5))
                    
                    Section("APPLICATION") {
                        if let url = URL(string: defaultURL) {
                            Link("Terms of Service", destination: url)
                            Link("Privacy Policy", destination: url)
                            Link("Company Website", destination: url)
                            Link("Learn More", destination: url)
                        }
                    }
                    .listRowBackground(Color.theme.background.opacity(0.5))
                }
                .listStyle(.grouped)
            }
            .scrollContentBackground(.hidden)
            .background(Color.theme.background)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(searchText: $viewModel.searchText)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
