//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

struct CircleButtonView: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(.headline))
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0,
                y: 0)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(imageName: "info")
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(imageName: "info")
        .preferredColorScheme(.dark)
}



