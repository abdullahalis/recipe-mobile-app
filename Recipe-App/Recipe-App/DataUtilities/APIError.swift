//
//  APIError.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/11/25.
//

import Foundation

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
