//
//  RecipeDetailViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation

struct RecipeDetailViewState {
    var title: String
    var image: String
    var extendedIngredients: [Ingredient]
    var steps: [Step]
}

class RecipeDetailViewModel: ObservableObject {
    @Published private(set) var recipe: RecipeDetailViewState
    
    init(with recipe: Recipe) {
        var steps: [Step] {
            return recipe.analyzedInstructions.isEmpty
                ? []
                : recipe.analyzedInstructions[0].steps
        }

        self.recipe = RecipeDetailViewState(
            title: recipe.title,
            image: recipe.image,
            extendedIngredients: recipe.extendedIngredients,
            steps: steps
        )
    }
    
    var ingredientList: [String] {
        return recipe.extendedIngredients.map { $0.original }
    }
    
    var stepList: [String] {
        return recipe.steps.map { $0.step }
    }
}
