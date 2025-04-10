//
//  APIManager.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation


final class APIManager: ObservableObject {
//    // url of API that we are calling
//    let endpoint: String
//    
//    init(endpoint: String) {
//        self.endpoint = endpoint
//    }
    
   
    
    // Get data from API
    public func fetchData(endpoint: String) async throws -> Data {
        // Get data if url is valid
       guard let url = URL(string: endpoint) else {
           print("Invalid URL")
           throw APIError.invalidURL
       }

       do {
           let (data, response) = try await URLSession.shared.data(from: url)
           
           // Check the response
           guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               print("Invalid response: \(response)")
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
    case emptyData
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is invalid."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Could not decode server data."
        case .emptyData:
            return "Server data is empty."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
