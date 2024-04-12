//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 15/03/24.
//

import SwiftUI

struct RecipeDetailView {
    @ObservedObject private var viewModel: RecipeDetailViewModel
    @State private var showingSimilarRecipeAlert = false
    private var recipe: Recipe
    
    init(with recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = .init(with: recipe)
    }
}

extension RecipeDetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            List {
                RecipeDetailHeaderView(recipe: viewModel.recipe)
                    .listRowBackground(Color.clear)
                
                Section(header: Text("Ingredients")) {
                    ForEach(
                        Array(viewModel.ingredientList.enumerated()),
                        id: \.element
                    ) { index, ingredient in
                        HStack(alignment: .top, spacing: 16) {
                            Text("\(index + 1)")
                                .bold()
                                .frame(alignment: .leading)
                            
                            Text(ingredient)
                                .frame(alignment: .trailing)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                    }
                }
                
                if !viewModel.stepList.isEmpty {
                    Section(header: Text("Instructions")) {
                        ForEach(
                            Array(viewModel.stepList.enumerated()),
                            id: \.element
                        ) { index, step in
                            HStack(alignment: .top, spacing: 16) {
                                Text("\(index + 1)")
                                    .bold()
                                    .frame(alignment: .leading)
                                
                                Text(step)
                                    .frame(alignment: .trailing)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarItems
        }
        .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
    }
}

// MARK: - Toolbar
extension RecipeDetailView {
    @ToolbarContentBuilder var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 8) {
                Button {
                    // TODO: - add to favorites
                } label: {
                    Image(systemName: "heart")
                }
                
                Button {
                    showingSimilarRecipeAlert = true
                } label: {
                    Image(systemName: "text.magnifyingglass")
                }
                .alert("Search for a similar recipe?", isPresented: $showingSimilarRecipeAlert) {
                    Button("Go for it!") {
                        Task {
                            await viewModel.getSimilarRecipe()
                        }
                    }
                    
                    Button("Not Now") {
                        showingSimilarRecipeAlert = false
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(with: .init(id: 0))
}
