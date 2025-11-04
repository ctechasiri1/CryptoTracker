//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeIn(duration: 1.2) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: false)
}
