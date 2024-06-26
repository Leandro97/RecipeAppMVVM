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
    
    @ObservedObject private var viewModel: RecipeDetailViewModel = .init()
    @State private var isIngredientsExpanded = true
    @State private var isInstructionsExpanded = true
    @State private var showingSimilarRecipeAlert = false
    private var recipe: Recipe?
    private var favoriteRecipe: FavoriteRecipeDataModel?
    private var customRecipeId: Int?
    
    init(with recipe: Recipe) {
        self.recipe = recipe
    }
    
    init(withFavorite favoriteRecipe: FavoriteRecipeDataModel) {
        if favoriteRecipe.isCustom {
            self.customRecipeId = Int(favoriteRecipe.recipeId)
        } else {
            self.favoriteRecipe = favoriteRecipe
        }
    }
    
    init(withCustomId customRecipeId: Int) {
        self.customRecipeId = customRecipeId
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
        .onAppear {
            Task {
                if let recipe {
                    viewModel.set(recipe: recipe)
                } else if let favoriteRecipe {
                    await viewModel.getFavoriteRecipeData(with: favoriteRecipe.recipeId)
                } else if let customRecipeId {
                    await viewModel.getCustomRecipeData(with: customRecipeId)
                }
            }
        }
    }
}

// MARK: - Toolbar
extension RecipeDetailView {
    private var isFavorite: Bool {
        guard let recipe = viewModel.recipe else { return false }
        return favoriteRecipes.map { Int($0.recipeId) }.contains(recipe.id)
    }
    
    @ToolbarContentBuilder var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack(spacing: 8) {
                Button {
                    // TODO: - fix favorite when similar recipe is displayed
                    if let recipe = viewModel.recipe {
                        if isFavorite {
                            FavoriteRecipeDataModel.deleteFavorite(recipe, with: context)
                        } else {
                            FavoriteRecipeDataModel.setAsFavorite(recipe, with: context, isCustom: false)
                        }
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
