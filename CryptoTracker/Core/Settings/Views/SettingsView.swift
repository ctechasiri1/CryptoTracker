//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/8/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("hello")
                }
                
                Section {
                    Text("hello")
                }
                
                
            }
            .listStyle(.grouped)
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
