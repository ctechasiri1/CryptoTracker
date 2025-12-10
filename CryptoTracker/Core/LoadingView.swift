//
//  LoadingView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 12/9/25.
//
import Combine
import SwiftUI

struct LoadingView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showLoadingView: Bool
    
    @State private var loadingText: [String] = "Loading coin details".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var timerCount: Int = 0
    @State private var loopCount: Int = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            Image(colorScheme == .light ? "logo-transparent-black" : "logo-transparent")
                .frame(width: 100, height: 100)
                .offset(y: -15)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.system(.headline, weight: .heavy))
                                .foregroundStyle(colorScheme == .light ? Color.black.opacity(0.6) : Color.launch.accent)
                                .transition(AnyTransition.scale.animation(.easeIn))
                                .offset(y: index == timerCount ? -5 : 0)
                        }
                    }
                }
            }
            .offset(y: 50)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring) {
                let lastIndex = loadingText.count - 1
                if timerCount == lastIndex {
                    timerCount = 0
                    loopCount += 1
                    if loopCount == 1 {
                        showLoadingView = false
                    }
                } else {
                    timerCount += 1
                }
            }
        }
    }
}

#Preview {
    LoadingView(showLoadingView: .constant(true))
}
