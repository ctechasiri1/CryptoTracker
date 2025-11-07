//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.accent : Color.theme.secondaryText)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Button {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    } label: {
                        Image(systemName: searchText.isEmpty ? "": "xmark")
                    }
                }
        }
        .font(.system(.headline))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.2),
                        radius: 10,
                        x: 0,
                        y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .environmentObject(HomeViewModel())
}
