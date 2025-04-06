//
//  APIManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation

final class APIManager: ObservableObject {
    
    func fetchRecipes() async throws -> [Recipe] {
        // url of API that we are calling
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        // Get data if url is valid
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        } // TODO: handle url error
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipes = try decoder.decode(Recipes.self, from: data)
            return recipes.recipes
        } catch {
            print("Error: decoding failed")
            throw APIError.decodingFailed
        }
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Could not decode the data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
