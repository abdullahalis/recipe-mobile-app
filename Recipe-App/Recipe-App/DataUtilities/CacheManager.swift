//
//  CacheManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation
import UIKit

final class CacheManager: ObservableObject {
    static let shared = CacheManager()
    
    private var cache: [String: UIImage] = [:]
    // Use dispatch queue to ensure one thread is accessing at a time
    private let queue = DispatchQueue(label: "image.cache.queue")

    private init() {}

    func get(key: String) -> UIImage? {
        queue.sync {
            return cache[key]
        }
    }

    func set(image: UIImage, key: String) {
        queue.sync {
            cache[key] = image
        }
    }
}
