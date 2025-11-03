//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPorfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                CustomNavigationHeader(showPorfolio: $showPorfolio)
                
                Spacer()
            }
        }
    }
}

// MARK: Header
private struct CustomNavigationHeader: View {
    @Binding var showPorfolio: Bool
    
    var body: some View {
        HStack {
            CircleButtonView(imageName: showPorfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: showPorfolio)
                )
            
            Spacer()
            
            Text(showPorfolio ? "Portfolio" : "Live Prices")
                .font(.system(.headline, weight: .heavy))
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(imageName: "chevron.left")
                .rotationEffect(Angle(degrees: showPorfolio ? 180 : 0))
                .animation(.bouncy(duration: 1.5), value: showPorfolio)
                .onTapGesture {
                    showPorfolio.toggle()
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
}
