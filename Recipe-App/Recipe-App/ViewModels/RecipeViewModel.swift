//
//  RecipeViewModel.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var recipesLoading = true
    
    @Published var error: RecipeError?
    @Published var hasError = false
    
    private let apiManager = APIManager()
    
    func loadRecipes() async {
        
        recipesLoading = true
        hasError = false
        do {
            try await recipes = apiManager.fetchRecipes()
            recipesLoading = false
            print("got recipes")
        } catch let apiError as APIError {
            print("API Error")
            self.hasError = true
            self.error = .custom(error: apiError)
        } catch {
            self.hasError = true
            self.error = .custom(error: error)
        }
    }
}

extension RecipeViewModel {
    enum RecipeError: LocalizedError {
        case custom(error: Error)
        case decodeFailed
        
        var errorDescription: String? {
            switch self {
            case .decodeFailed:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}

