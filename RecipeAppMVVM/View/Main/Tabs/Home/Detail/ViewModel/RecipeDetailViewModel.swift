//
//  RecipeDetailViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published var isLoading: Bool = false
    @Published var recipe: Recipe?
    @Published var favoriteRecipe: FavoriteRecipeDataModel?
    @Published var customRecipeId: Int?
    
    init(
        with recipe: Recipe,
        service: RecipeServiceProtocol = RecipeService()
    ) {
        self.recipe = recipe
        self.service = service
    }
    
    init(
        with favoriteRecipe: FavoriteRecipeDataModel,
        service: RecipeServiceProtocol = RecipeService()
    ) {
        self.favoriteRecipe = favoriteRecipe
        self.service = service
        
        Task {
            await getFavoriteRecipeData()
        }
    }
    
    init(
        with customRecipeId: Int,
        service: RecipeServiceProtocol = RecipeService()
    ) {
        self.customRecipeId = customRecipeId
        self.service = service
        
        Task {
            await getCustomRecipeData()
        }
    }
}

// MARK: - Public functions
extension RecipeDetailViewModel {
    func getSimilarRecipe() async {
        // TODO: fix touch on detail (it's redirecting to similar recipe on card touch)
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            guard 
                let recipe = recipe,
                let similarRecipe = try await service.getSimilarRecipe(with: recipe.id)
            else { return }
            
            self.recipe = similarRecipe
        } catch {
            // TODO: - handle error
        }
    }
}

// MARK: - Private functions
extension RecipeDetailViewModel {
    private func getFavoriteRecipeData() async {
        guard let favoriteRecipe = favoriteRecipe else { return }
        
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipe = try await service.getRecipe(with: Int(favoriteRecipe.recipeId))
        } catch {
            // TODO: - handle error
        }
    }
    
    private func getCustomRecipeData() async {
        guard let customRecipeId = customRecipeId else { return }
        
        // self.recipe = // TODO
    }
}

// MARK: - Properties
extension RecipeDetailViewModel {
    var ingredientList: [String] {
        return recipe?.extendedIngredients.map { $0.original } ?? []
    }
    
    var stepList: [String] {
        var steps: [Step] {
            guard let recipe = recipe else { return [] }
            
            return recipe.analyzedInstructions.isEmpty
                ? []
                : recipe.analyzedInstructions[0].steps
        }
        
        return steps.map { $0.step }
    }
}
