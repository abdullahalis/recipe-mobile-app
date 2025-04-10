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
    private let imageCache = ImageCache.shared
    
    init(endpoint: String) {
        self.endpoint = endpoint

    }
    
    func fetchImage() async throws -> UIImage {
        do {
            //print("fetching from id: \(uuid), link: \(apiManager.endpoint)")
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
