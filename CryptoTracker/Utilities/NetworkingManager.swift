//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import Foundation

class NetworkingManager {
    static func downloadFromURL(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkingError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                throw NetworkingError.badServerResponse
            }
        }
        
        return data
    }
}
