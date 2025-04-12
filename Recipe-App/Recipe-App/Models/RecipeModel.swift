//
//  RecipeModel.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let sourceUrl: String?
    let youtubeUrl: String?
}
