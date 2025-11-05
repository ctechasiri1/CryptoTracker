//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import Foundation

class NetworkingManager {
    static func download(url: URL) async throws -> (data: Data, response: URLResponse) {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        return (data, response)
    }
    
    static func handleURLResponse(urlResponse: URLResponse) throws {
        if let httpResponse = urlResponse as? HTTPURLResponse {
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                throw NetworkingError.badServerResponse
            }
        }
    }
}
