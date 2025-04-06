//
//  HomeView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = RecipeViewModel()

    
    var body: some View {
        
        NavigationStack {
            Group {
                if viewModel.recipesLoading {
                    ProgressView()
                } else {
                    RecipeListView(recipes: viewModel.recipes)
                    
                }
            }
            
        }
        
        .padding()
        .task {
            await viewModel.loadRecipes()
        }
        .alert("Something went wrong", isPresented: $viewModel.hasError, presenting: viewModel.error) { _ in
            Button("Retry") {
                Task {
                    await viewModel.loadRecipes()
                }
            }
             Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    HomeView()
}
