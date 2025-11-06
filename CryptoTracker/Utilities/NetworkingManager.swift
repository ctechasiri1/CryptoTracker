//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/4/25.
//

import Foundation

class NetworkingManager {
    static func downloadFromURL<T:Decodable>(urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw NetworkingError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw NetworkingError.badServerResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dataDecoded = try decoder.decode(T.self, from: data)
        
        return dataDecoded
    }
}
