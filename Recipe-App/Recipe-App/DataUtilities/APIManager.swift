//
//  APIManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation


final class APIManager: ObservableObject {
    
    // Get data from API endpoint
    public func fetchData(endpoint: String) async throws -> Data {
       guard let url = URL(string: endpoint) else {
           print("Invalid URL")
           throw APIError.invalidURL
       }

       do {
           let (data, response) = try await URLSession.shared.data(from: url)
           
           // Check the response
           guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
               print("Invalid response: \(response)")
               throw APIError.invalidResponse
           }
           return data
       } catch {
           throw APIError.invalidResponse
       }
    }
}

