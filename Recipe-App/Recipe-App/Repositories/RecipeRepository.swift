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
    private let endpoint: String
    private let apiManager: APIManager = APIManager()
    
    init(endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") { // Default to full recipes API, this is only parameterized for testing
        self.endpoint = endpoint
    }
    
    func fetchRecipes() async throws-> [Recipe] {
        do {
            let data = try await apiManager.fetchData(endpoint: endpoint)
            return try await decodeRecipes(data: data)
        } catch {
            throw error
        }
    }
    
    // Decodes data response into recipes
    func decodeRecipes(data: Data) async throws -> [Recipe] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Convert snake case to camelcase
            
            let recipes = try decoder.decode(Recipes.self, from: data)
            return recipes.recipes
        } catch {
            print("Error: decoding failed")
            throw APIError.decodingFailed
        }
    }
}
