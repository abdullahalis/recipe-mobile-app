//
//  ImageLoad.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/7/25.
//

import Foundation
import UIKit

@MainActor
class ImageLoad: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var imageLoading: Bool = true
    
    @Published var error: APIError?
    @Published var hasError = false
    

    private let repository: ImageRepository
    
//    init(endpoint: String?) {
//        self.endpoint = endpoint
//    }
    init(endpoint: String) {
        self.repository = ImageRepositoryImpl(endpoint: endpoint)
    }
    
    func loadImage() async {
        
//        // Don't run if already loading the image
        guard image == nil && imageLoading == true else {
            return
        }
        
//        // validate URL
//        guard let endpoint = endpoint else {
//            error = APIError.invalidURL
//            hasError = true
//            return
//        }
        
//        let apiManager = APIManager(endpoint: endpoint)
        imageLoading = true
        hasError = false
        
        do {

            // Try to use data returned as URL for image
            self.image = try await repository.fetchImage()
//            if let image = UIImage(data: data) {
//                self.image = image
//            } else {
//                self.hasError = true
//                self.error = .decodingFailed
//            }
            
            imageLoading = false
            
        } catch let apiError as APIError {
            self.hasError = true
            self.error = apiError
            imageLoading = false
            
        } catch {
            self.hasError = true
            self.error = .unknown(error)
            imageLoading = false
        }
        
    }
}
