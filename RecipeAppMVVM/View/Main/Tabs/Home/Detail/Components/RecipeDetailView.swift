//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 15/03/24.
//

import SwiftUI

struct RecipeDetailView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: FavoriteRecipeDataModel.allFavorites) 
    private var favoriteRecipes: FetchedResults<FavoriteRecipeDataModel>
    
    @ObservedObject private var viewModel: RecipeDetailViewModel
    @State private var isIngredientsExpanded = true
    @State private var isInstructionsExpanded = true
    @State private var showingSimilarRecipeAlert = false
    private var recipe: Recipe
    
    init(with recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = .init(with: recipe)
    }
}

extension RecipeDetailView: View {
    var body: some View {
        List {
            Section {
                RecipeDetailHeaderView(recipe: viewModel.recipe)
                    .listRowBackground(Color.clear)
            }
            
            Section(
                header: SectionHeader(
                    title: "Ingredients",
                    isOn: $isIngredientsExpanded
                )
            ) {
                if isIngredientsExpanded {
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
            }
            
            if !viewModel.stepList.isEmpty {
                Section(
                    header: SectionHeader(
                        title: "Instructions",
                        isOn: $isInstructionsExpanded
                    )
                ) {
                    if isInstructionsExpanded {
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
    private var isFavorite: Bool {
        return favoriteRecipes.map { Int($0.recipeId) }.contains(recipe.id)
    }
    
    @ToolbarContentBuilder var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 8) {
                Button {
                    if isFavorite {
                        FavoriteRecipeDataModel.deleteFavorite(recipe, with: context)
                    } else {
                        FavoriteRecipeDataModel.setAsFavorite(recipe, with: context, isCustom: true)
                    }
                } label: {
                    isFavorite
                        ? Image(systemName: "heart.fill")
                        : Image(systemName: "heart")
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
