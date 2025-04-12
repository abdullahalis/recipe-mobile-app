//
//  CacheManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation
import SwiftUI

final class ImageCache {
    static let shared = ImageCache() // Singleton so one cache is shared across application
    let cache = LRUCache<String, UIImage>(capacity: 20) // Set capacity low to see if it works properly
}
