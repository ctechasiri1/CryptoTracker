//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/22/25.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
