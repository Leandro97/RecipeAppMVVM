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
            guard 
                let recipe = recipe,
                let similarRecipe = try await service.getSimilarRecipe(with: recipe.id)
            else { return }
            
            self.recipe = similarRecipe
        } catch {
            // TODO: - handle error
        }
    }

    func getFavoriteRecipeData(with id: Int64) async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipe = try await service.getRecipe(with: Int(id))
        } catch {
            // TODO: - handle error
        }
    }
    
    func getCustomRecipeData(with id: Int) async {
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
