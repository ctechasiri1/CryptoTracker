//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                .environmentObject(viewModel)
                .navigationViewStyle(StackNavigationViewStyle())
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
