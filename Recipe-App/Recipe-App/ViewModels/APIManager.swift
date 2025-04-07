//
//  APIManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation


final class APIManager: ObservableObject {
    // url of API that we are calling
    let endpoint: String
    
    init(endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") { // default to normal recipes endpoint
        self.endpoint = endpoint
    }
    
    // Calls API and returns the list of recipes
    func fetchRecipes() async throws -> [Recipe] {
        
        let data = try await fetchData()
        
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
    
    // Get data from API
    public func fetchData() async throws -> Data {
        // Get data if url is valid
       guard let url = URL(string: endpoint) else {
           print("Invalid URL")
           throw APIError.invalidURL
       }

       do {
           let (data, response) = try await URLSession.shared.data(from: url)

           // Check the response
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               print("Invalid response")
               throw APIError.invalidResponse
           }

           return data
       } catch {
           throw APIError.invalidResponse
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
