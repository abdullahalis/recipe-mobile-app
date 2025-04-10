////
////  HomeView.swift
////  Recipe-App
////
////  Created by Abdullah Ali on 4/4/25.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @StateObject private var viewModel = RecipeViewModel()
//    @State private var showFilter = false
//
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                
//                
//                // Recipe list
//                VStack {
//                    if viewModel.recipesLoading {
//                        Spacer()
//                        ProgressView()
//                        Spacer()
//                    } else {
////                        Button(action: {
////                            withAnimation {
////                                showFilter.toggle()
////                            }
////                        }) {
////                            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
////                        }
////                        .padding(.trailing)
//                        RecipeListView(recipes: viewModel.filteredRecipes)
//                    }
//                }
//                .navigationTitle("Recipes")
////                .navigationBarTitleDisplayMode(.automatic)
//                
//                // Floating filter button
//                                VStack {
//                                    Spacer()
//                                    
//                                        Button(action: {
//                                            withAnimation {
//                                                showFilter.toggle()
//                                            }
//                                        }) {
//                                            Image(systemName: "slider.horizontal.3")
//                                                .resizable()
//                                                .frame(width: 25, height: 25)
//                                                .padding()
//                                                .background(.gray)
//                                                .foregroundColor(.white)
//                                                .clipShape(Circle())
//                                                .shadow(radius: 5)
//                                        }
//                                        .padding(.trailing, 20)
//                                        .padding(.bottom, 30)
//                                    
//                                }
//
//                // Overlay filter view
//                if showFilter {
//                    Color.black.opacity(0.3)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation {
//                                showFilter = false
//                            }
//                        }
//
//                    // Slide-up Filter View
//                       VStack {
//                           Spacer()
//
//                           CuisineFilterView(
//                               allCuisines: Array(viewModel.cuisines).sorted(),
//                               selectedCuisines: $viewModel.selectedCuisines
//                           )
//                           .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.8)
//                           .padding()
//                           .background(
//                                       RoundedRectangle(cornerRadius: 20, style: .continuous)
//                                           .fill(.white)
//                                   )
//                           .shadow(radius: 10)
//                           .transition(.move(edge: .bottom).combined(with: .opacity))
//                       }
//                       .ignoresSafeArea(edges: .bottom)
//                       .animation(.easeInOut(duration: 0.3), value: showFilter) // Smooth animation
//                }
//            }
//            
////            .toolbar {
////                ToolbarItemGroup(placement: .navigationBarTrailing) {
////                    Button {
////                        withAnimation {
////                            showFilter.toggle()
////                        }
////                    } label: {
////                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
////                    }
////                }
////            }
//        }
//        .padding(.top, 0)
//        
//        .searchable(text: $viewModel.query)
//        .onChange(of: viewModel.query) { _, _ in viewModel.search() }
//        .onChange(of: viewModel.selectedCuisines) { _, _ in viewModel.search() }
//        .task {
//            await viewModel.loadRecipes()
//        }
//        .alert("Something went wrong", isPresented: $viewModel.hasError, presenting: viewModel.error) { _ in
//            Button("Retry") {
//                Task {
//                    await viewModel.loadRecipes()
//                }
//            }
//             Button("OK", role: .cancel) {}
//        } message: { error in
//            Text(error.localizedDescription)
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
