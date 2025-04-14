//
//  ImageLoad.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/7/25.
//

import Foundation
import SwiftUI

@MainActor
/// The main view model for managing image data and UI state.
///
/// - Parameter endpoint: A string representing the full URL of the image API endpoint.
class ImageLoadViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var imageLoading: Bool = true
    
    @Published var error: APIError?
    @Published var hasError = false

    private let repository: ImageRepository
    
    init(endpoint: String) {
        self.repository = ImageRepositoryImpl(endpoint: endpoint)
    }
    
    /// Loads image data asynchronously, updates internal state, and handles API errors.
    func loadImage() async {
        
        // Don't run if already loading the image
        guard image == nil && imageLoading == true else {
            return
        }
        
        imageLoading = true
        hasError = false
        
        do {
            defer {imageLoading = false}
            self.image = try await repository.fetchImage()
            
        } catch let apiError as APIError {
            self.hasError = true
            self.error = apiError
            
        } catch {
            self.hasError = true
            self.error = .unknown(error)
        }
        
    }
}
