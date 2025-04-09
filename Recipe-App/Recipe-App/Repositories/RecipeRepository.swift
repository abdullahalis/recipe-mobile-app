//
//  RecipeRepository.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/8/25.
//

import Foundation

protocol RecipeRepository {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeRepositoryImpl: RecipeRepository {
    
    private let apiManager: APIManager = APIManager(endpoint: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    
//    init(apiManager: APIManager) {
//        self.apiManager = apiManager
//    }
    
    func fetchRecipes() async throws-> [Recipe] {
        do {
            let data = try await apiManager.fetchData()
            return try await decodeRecipes(data: data)
        } catch {
            throw error
        }
    }
    
    // Decodes JSON response into recipes
    func decodeRecipes(data: Data) async throws -> [Recipe] {
        do {
            let decoder = JSONDecoder()
            // Convert snake case to camelcase
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipes = try decoder.decode(Recipes.self, from: data)
            return recipes.recipes
        } catch {
            print("Error: decoding failed")
            throw APIError.decodingFailed
        }
    }
}
