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
    
    @Published var error: APIError?
    @Published var hasError = false
    
    private let repository: RecipeRepository
    
    init(repository: RecipeRepository = RecipeRepositoryImpl()) {
        self.repository = repository
    }
    
    // Load recipes from API
    func loadRecipes() async {
        
        recipesLoading = true
        hasError = false
        
        do {
            recipes = try await repository.fetchRecipes()
            
            if recipes.isEmpty {
                self.hasError = true
                self.error = .emptyData
            }
            
            recipesLoading = false
            
        } catch let apiError as APIError {
            self.hasError = true
            self.error = apiError
        } catch {
            self.hasError = true
            self.error = .unknown(error)
        }
    }
    
//    // Decodes JSON response into recipes
//    func decodeRecipes(data: Data) async throws -> [Recipe] {
//        do {
//            let decoder = JSONDecoder()
//            // Convert snake case to camelcase
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let recipes = try decoder.decode(Recipes.self, from: data)
//            return recipes.recipes
//        } catch {
//            print("Error: decoding failed")
//            throw APIError.decodingFailed
//        }
//    }
}
