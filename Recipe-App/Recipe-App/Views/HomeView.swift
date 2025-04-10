//
//  HomeView.swift
//  Recipe-App
//
//  Created by Abdullah Ali on 4/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = RecipeViewModel()
    @State private var showFilter = false
    @State private var showFilterButton = true
    
    var body: some View {
        Group {
            if viewModel.recipesLoading {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            else if viewModel.hasError {
                ErrorView(message: viewModel.error!.errorDescription!) {
                    Task {
                        await viewModel.loadRecipes()
                    }
                }
            } else {
                RecipeView(viewModel: viewModel, showFilter: $showFilter, showFilterButton: $showFilterButton)
            }
        }
        .task {
            await viewModel.loadRecipes()
        }
        
    }
}

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Error icon
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.orange)

            // Error title
            Text("Something went wrong")
                .font(.title2)
                .fontWeight(.semibold)

            // Error message
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Retry button
            Button(action: retryAction) {
                Text("Retry")
                    .bold()
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}



#Preview {
    HomeView()
}

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var showFilter: Bool
    @Binding var showFilterButton: Bool
    var body: some View {
        ZStack {
            NavigationStack {
                Group {
                    if viewModel.filteredRecipes.isEmpty {
                        Text("No matching recipes.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    else {
                        RecipeListView(recipes: viewModel.filteredRecipes, showFilterButton: $showFilterButton)
                    }
                }.navigationTitle("Recipes")
            }
            
            .padding(.top, 0)
            .searchable(text: $viewModel.query, prompt: "Search recipes")
            .onChange(of: viewModel.query) { _, _ in viewModel.search() }
            .onChange(of: viewModel.selectedCuisines) { _, _ in viewModel.search() }
            .refreshable {
                print("refreshing")
                Task {
                    await viewModel.loadRecipes()
                }
            }
            
            if showFilterButton {
                VStack {
                    Spacer()
                    FilterButtonView(viewModel: viewModel, showFilter: $showFilter)
                }
            }
            
        }
    }
}

struct FilterButtonView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var showFilter: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                showFilter.toggle()
            }
        }) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                    .background(.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                if !viewModel.selectedCuisines.isEmpty {
                    Text("\(viewModel.selectedCuisines.count)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
        }
        .padding(.trailing, 20)
        .padding(.bottom, 30)
        .popover(isPresented: $showFilter) {
            CuisineFilterView(
                allCuisines: Array(viewModel.cuisines).sorted(),
                selectedCuisines: $viewModel.selectedCuisines,
                onSave: {
                    showFilter = false
                }
            )
        }
    }
}
