//
//  NetworkingError.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import Foundation

enum NetworkingError: LocalizedError {
    case badURL
    case cannotDecodeContentData
    case badServerResponse
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            "[⚠️] Networking Error: Bad URL"
        case .cannotDecodeContentData:
            "[⚠️] Networking Error: Cannot Decode Content Data"
        case .badServerResponse:
            "[⚠️] Networking Error: Bad Server Response"
        case .unknown:
            "[⚠️] Networking Error: Unknown Error"
        }
    }
}
