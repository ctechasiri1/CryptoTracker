//
//  DecodingError.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import Foundation

enum DecodingError: LocalizedError {
    case jsonDecoding
    case imageDecoding
    
    var localizedDescription: String {
        switch self {
        case .jsonDecoding:
            "[⚠️] Decoding Error: There was an error decoding the JSON data."
        case .imageDecoding:
            "[⚠️] Decoding Error: There was an error decoding the UIImage data."
        }
    }
}
