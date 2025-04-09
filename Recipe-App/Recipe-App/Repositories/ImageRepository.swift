//
//  ImageRepository.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation
import UIKit

protocol ImageRepository {
    func fetchImage() async throws -> UIImage
}

class ImageRepositoryImpl: ImageRepository {
    private let apiManager: APIManager
    private let cacheManager: CacheManager
    
    init(apiManager: APIManager, cacheManager: CacheManager) {
        self.apiManager = apiManager
        self.cacheManager = cacheManager
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            //print("fetching from id: \(uuid), link: \(apiManager.endpoint)")
            if let cached = cacheManager.get(key: apiManager.endpoint) {
                return cached
            }
            let data = try await apiManager.fetchData()
            
            // Try to use data returned as URL for image
            if let image = UIImage(data: data) {
                print("new image")
                cacheManager.set(image: image, key: apiManager.endpoint)
                return image
            } else {
                throw APIError.decodingFailed
            }
        } catch {
            throw error
        }
    }
}
