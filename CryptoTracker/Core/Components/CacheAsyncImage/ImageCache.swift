//
//  ImageCache.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/6/25.
//

import SwiftUI
import UIKit

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
    
    init() {
        // Configure cache limits
        ImageCache.shared.countLimit = 100 // Maximum 100 images
        ImageCache.shared.totalCostLimit = 50 * 1024 * 1024 // 50MB limit
    }
}
