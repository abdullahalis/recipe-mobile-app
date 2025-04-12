//
//  ImageRepository.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation
import SwiftUI

protocol ImageRepository {
    func fetchImage() async throws -> UIImage
}

class ImageRepositoryImpl: ImageRepository {
    private let endpoint: String
    
    private let apiManager: APIManager = APIManager()
    private let imageCache = ImageCache.shared // Use singleton image cache so it is shared among all repository objects
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            // Get image from cache, otherwise call API
            if let cached = imageCache.cache.get(key: endpoint) {
                print("got from cache")
                return cached
            }
            let data = try await apiManager.fetchData(endpoint: endpoint)
            
            // Try to use data returned as URL for image
            if let image = UIImage(data: data) {
                print("new image fetched: \(data)")
                imageCache.cache.set(key: endpoint, value: image)
                return image
            } else {
                throw APIError.decodingFailed
            }
        } catch {
            throw error
        }
    }
}
