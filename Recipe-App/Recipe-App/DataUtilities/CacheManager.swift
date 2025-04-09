//
//  CacheManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation
import UIKit

//final class CacheManager {
//    // Singleton so one cache is shared across application
//    static let shared = CacheManager()
//    
//    private var cache: [String: UIImage] = [:]
//    // Use a concurrent dispatch queue to prevent data races
//    private let queue = DispatchQueue(label: "image.cache.queue", attributes: .concurrent)
//
//    init(cache: ) {}
//
//    func get(key: String) -> UIImage? {
//        // Allow multiple threads to concurrently read
//        queue.sync {
//            return cache[key]
//        }
//    }
//
//    func set(image: UIImage, key: String) {
//        // Only one thread can write at a time
//        queue.sync(flags: .barrier) {
//            cache[key] = image
//        }
//    }
//}

final class ImageCache {
    // Singleton so one cache is shared across application
    static let shared = ImageCache()
    
    // Set capacity fairly low to see if it works
    let cache = LRUCache<String, UIImage>(capacity: 20)

}
