//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/11/25.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var searchText: String
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
            searchText = ""
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton(searchText: .constant("test"))
}
