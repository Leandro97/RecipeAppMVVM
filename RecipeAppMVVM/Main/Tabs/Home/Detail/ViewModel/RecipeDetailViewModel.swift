//
//  RecipeDetailViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import CoreData
import Foundation

class RecipeDetailViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published var isLoading = false
    @Published var recipe: Recipe?
    @Published var hasError = false
    @Published var recipeDeleted = false
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
    
    func set(recipe: Recipe) {
        self.recipe = recipe
    }
}

// MARK: - Public functions
extension RecipeDetailViewModel {
    func getSimilarRecipe() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            guard let recipe = recipe else { return }
            let recipeId = try await service.getSimilarRecipe(with: recipe.id)
            self.recipe = try await service.getRecipe(with: recipeId)
        } catch {
            self.hasError = true
        }
    }

    func getFavoriteRecipeData(with id: Int64) async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipe = try await service.getRecipe(with: Int(id))
        } catch {
            self.hasError = true
        }
    }
    
    @MainActor
    func getCustomRecipeData(with id: Int, and context: NSManagedObjectContext) {
        guard let model = CustomRecipeDataModel.getRecipe(with: id, and: context) else { return }
        self.recipe = Recipe(with: model)
    }
    
    @MainActor
    func deleteRecipe(with context: NSManagedObjectContext) {
        self.recipeDeleted = false
        guard let recipe = recipe else { return }
        
        do {
            try CustomRecipeDataModel.deleteRecipe(with: recipe.id, and: context)
            self.recipeDeleted = true
        } catch {
            self.hasError = true
        }
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
