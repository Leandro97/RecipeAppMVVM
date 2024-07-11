//
//  Ingredient.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Ingredient: Decodable {
    let original: String
    
    // TODO: - Remove defaults
    init(original: String = "1 tbsp of butter") {
        self.original = original
    }
}

extension Ingredient {
    init(with model: IngredientDataModel) {
        self.original = model.original ?? ""
    }
}
