//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import Foundation
import UIKit

class CoinImageService {
    let imageString: String
    
    init(imageString: String) {
        self.imageString = imageString
    }
    
    func getImagesFromURL() async throws -> UIImage {
        do {
            let imageData = try await NetworkingManager.downloadFromURL(urlString: imageString)
            
            if let processedImage = UIImage(data: imageData) {
                return processedImage
            } else {
                throw DecodingError.imageDecoding
            }
        } catch {
            throw NetworkingError.cannotDecodeContentData
        }
    }
}
