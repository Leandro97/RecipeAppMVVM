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
    var instructions: [Instruction]
}

extension RecipeDetailView {
    class ViewModel: ObservableObject {
        @Published private(set) var state: RecipeDetailViewState
        
        init(with recipe: Recipe) {
            self.state = RecipeDetailViewState(
                title: recipe.title,
                image: recipe.image,
                extendedIngredients: recipe.extendedIngredients,
                instructions: recipe.instructions
            )
        }
        
        func getIngredientList() -> String {
            var text = ""
            state.extendedIngredients.enumerated().forEach { (index, value) in
                text += "\(index + 1) - \(value.original)\n"
            }
            return text
        }
        
        func getInstructionList() -> String {
            var text = ""
            state.instructions.enumerated().forEach { (index, value) in
                text += "\(index + 1) - \(value.step)\n"
            }
            return text
        }
    }
}
