//
//  RecipeDetailView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var loadingVideo = true
    
    @Binding var showFilterButton: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Recipe title
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Cuisine label
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Recipe image
                if let endpoint = recipe.photoUrlLarge {
                    ZStack {

                        ImageLoadView(endpoint: endpoint)
                            .clipped()
                            .cornerRadius(12)
                    }
                }

                // YouTube video
                if let youtubeURL = recipe.youtubeUrl {
                    ZStack {
                        YoutubePlayerView(videoURL: youtubeURL, isLoading: $loadingVideo)
                        .cornerRadius(12)
                        
                        // Progress view if video stil loading
                        if loadingVideo {
                            VStack {
                                ProgressView()
                                Text("Loading video...")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                }

                // Source link
                if let sourceURL = recipe.sourceUrl,
                   let url = URL(string: sourceURL) {
                    Link("View Recipe Source", destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
        // Turn off filter button
        .onAppear() {
            showFilterButton = false
        }
    }
        
}


#Preview {
    RecipeDetailView(recipe: Recipe(
        cuisine: "Malaysian",
        name: "Apam Balikkkkkkkkkkkkkkkkk",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    ),
        showFilterButton: .constant(true))
}
