//
//  RecipeDetailViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation

//struct RecipeDetailViewState {
//    var id: Int = 0
//    var title: String = ""
//    var image: String = ""
//    var extendedIngredients: [Ingredient] = []
//    var steps: [Step] = []
//}

class RecipeDetailViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published var isLoading: Bool = false
    @Published var recipe: Recipe
    
    init(
        with recipe: Recipe,
        service: RecipeServiceProtocol = RecipeService()
    ) {
        self.recipe = recipe
        self.service = service
    }
    
//    private func setState(for recipe: Recipe) {
//        var steps: [Step] {
//            return recipe.analyzedInstructions.isEmpty
//                ? []
//                : recipe.analyzedInstructions[0].steps
//        }
//        
//        self.recipe = RecipeDetailViewState(
//            id: recipe.id,
//            title: recipe.title,
//            image: recipe.image,
//            extendedIngredients: recipe.extendedIngredients,
//            steps: steps
//        )
//    }
}

// MARK: - functions
extension RecipeDetailViewModel {
    func getSimilarRecipe() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            guard 
                let recipe = try await service.getSimilarRecipe(with: recipe.id)
            else { return }
            
            self.recipe = recipe
        } catch {
            // TODO: - handle error
        }
    }
}

// MARK: - Properties
extension RecipeDetailViewModel {
    var ingredientList: [String] {
        return recipe.extendedIngredients.map { $0.original }
    }
    
    var stepList: [String] {
        var steps: [Step] {
            return recipe.analyzedInstructions.isEmpty
                ? []
                : recipe.analyzedInstructions[0].steps
        }
        
        return steps.map { $0.step }
    }
}
