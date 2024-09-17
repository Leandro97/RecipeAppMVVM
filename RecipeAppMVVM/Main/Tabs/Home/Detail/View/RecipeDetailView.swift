//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 15/03/24.
//

import SwiftUI

struct RecipeDetailView {
    @Environment(\.presentationMode) var isPresented
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(fetchRequest: FavoriteRecipeDataModel.allFavorites)
    private var favoriteRecipes: FetchedResults<FavoriteRecipeDataModel>
    
    @StateObject private var viewModel: RecipeDetailViewModel = .init()
    @State private var headerId = UUID()
    @State private var isIngredientsExpanded = true
    @State private var isInstructionsExpanded = true
    @State private var showSimilarRecipeAlert = false
    @State private var showDeleteRecipeAlert = false
    @State private var showGenericErrorAlert = false
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
                    .id(headerId)
            }
            
            Section(
                header: SectionHeader(
                    title: "Ingredients",
                    isOn: $isIngredientsExpanded
                )
            ) {
                if isIngredientsExpanded {
                    ForEach(viewModel.ingredientList, id: \.self) { item in
                        HStack(alignment: .top, spacing: 16) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .frame(alignment: .topLeading)
                                .padding(.top, 8)
                            
                            Text(item)
                                .frame(alignment: .topTrailing)
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
                            id: \.offset
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
                    viewModel.getCustomRecipeData(with: customRecipeId, and: context)
                }
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Service error!"),
                message: Text("Please, try again later."),
                dismissButton: .default(Text("OK"))
            )
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
                if let recipe = viewModel.recipe , recipe.isCustom {
                    NavigationLink(destination: AddCustomRecipeView(with: recipe, isFavorite: isFavorite)) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
                
                Button {
                    if let recipe = viewModel.recipe {
                        do {
                            if isFavorite {
                                try FavoriteRecipeDataModel.delete(recipe, with: context)
                            } else {
                                try FavoriteRecipeDataModel.create(recipe, with: context)
                            }
                        } catch {
                            showGenericErrorAlert = true
                        }
                    }
                } label: {
                    isFavorite
                        ? Image(systemName: "heart.fill")
                        : Image(systemName: "heart")
                }
                
                if let recipe, !recipe.isCustom {
                    Button {
                        showSimilarRecipeAlert = true
                    } label: {
                        Image(systemName: "text.magnifyingglass")
                    }
                    .alert("Search for a similar recipe?", isPresented: $showSimilarRecipeAlert) {
                        Button("Go for it!") {
                            Task {
                                await viewModel.getSimilarRecipe()
                            }
                        }
                        
                        Button("Not Now") {
                            showSimilarRecipeAlert = false
                        }
                    }
                } else {
                    Button {
                        showDeleteRecipeAlert = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .alert("Delete your recipe?", isPresented: $showDeleteRecipeAlert) {
                        Button("Yes") {
                            viewModel.deleteRecipe(with: context)
                        }
                        
                        Button("Cancel") {
                            showDeleteRecipeAlert = false
                        }
                    }
                }
            }
            .alert("Something went wrong! Try again later.", isPresented: $showGenericErrorAlert) {}
            .onChange(of: viewModel.recipeDeleted) { value in
                if value {
                    isPresented.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(with: .init(id: 0))
}
