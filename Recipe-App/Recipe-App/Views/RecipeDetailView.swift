//
//  RecipeDetailView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: recipe.photoUrlLarge)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }

                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let sourceURL = recipe.sourceUrl,
                   let url = URL(string: sourceURL) {
                    Link("View Recipe Source", destination: url)
                        .foregroundColor(.blue)
                }

                if let youtubeURL = recipe.youtubeUrl,
                   let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"))
}
