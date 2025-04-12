//
//  RecipeViewModel.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    private(set) var recipes: [Recipe] = []
    private(set) var cuisines: Set<String> = []
    
    @Published var filteredRecipes: [Recipe] = []
    @Published var selectedCuisines: Set<String> = []
    @Published var query: String = ""
    
    @Published var error: APIError?
    @Published var hasError = false
    @Published var recipesLoading = true
    
    private let repository: RecipeRepository
    
    init(repository: RecipeRepository = RecipeRepositoryImpl()) {
        self.repository = repository
    }
    
    // Load recipes from API
    func loadRecipes() async {
        recipesLoading = true
        hasError = false
        
        do {
            recipes = try await repository.fetchRecipes()
            filteredRecipes = recipes
            
            for recipe in recipes {
                cuisines.insert(recipe.cuisine)
            }
            
            if recipes.isEmpty {
                self.hasError = true
                self.error = .emptyData
            }
            
            recipesLoading = false
            
        } catch let apiError as APIError {
            self.hasError = true
            self.error = apiError
            recipesLoading = false
        } catch {
            self.hasError = true
            self.error = .unknown(error)
            recipesLoading = false
        }
    }
    
    // Handle user searches and filters
    func search() {
        filteredRecipes = recipes.filter { recipe in
            let matchesQuery = query.isEmpty || recipe.name.localizedCaseInsensitiveContains(query)
            let matchesCuisine = selectedCuisines.isEmpty || selectedCuisines.contains(recipe.cuisine)
            return matchesQuery && matchesCuisine
        }
    }
}
