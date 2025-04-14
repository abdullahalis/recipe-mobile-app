//
//  RecipeViewModel.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import Foundation

/// The main view model for managing recipe data, search functionality, and UI state.
///
/// - Parameter repository: The recipe data source (defaults to `RecipeRepositoryImpl`).
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
    
    /// Loads recipe data asynchronously, updates internal state, and handles API errors.
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
    
    /// Filters the loaded recipes based on the search query and selected cuisines.
    func search() {
        filteredRecipes = recipes.filter { recipe in
            let matchesQuery = query.isEmpty || recipe.name.localizedCaseInsensitiveContains(query)
            let matchesCuisine = selectedCuisines.isEmpty || selectedCuisines.contains(recipe.cuisine)
            return matchesQuery && matchesCuisine
        }
    }
}
