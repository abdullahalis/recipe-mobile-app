//
//  RecipeListView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import SwiftUI

struct RecipeListView: View {
    var recipes: [Recipe]
    @Binding var showFilterButton: Bool // passing flag to hide filter button when recipe detail page dispalyed

    var body: some View {
        List(recipes, id: \.uuid) { recipe in
            NavigationLink(value: recipe) {
                // Recipe row
                HStack {
                    // Image
                    Group {
                        if recipe.photoUrlSmall != nil {
                            ImageLoadView(endpoint: recipe.photoUrlSmall!)
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(8)
                        }
                    }
                    
                    // Name and cuisine
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        Text(recipe.cuisine)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        // Open detail view of recipe when a row is clicked
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailView(recipe: recipe, showFilterButton: $showFilterButton)
        }
        .onAppear() {
            showFilterButton = true
        }
    }
}


#Preview {
    RecipeListView(recipes: [
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
    ],
                   showFilterButton: .constant(true))
}
