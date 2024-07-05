//
//  Ingredient.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Ingredient: Decodable {
    let name: String
    let original: String
    
    // TODO: - Remove
    init() {
        self.name = "butter"
        self.original = "1 tbsp of butter"
    }
}

extension Ingredient {
    init(with model: IngredientDataModel) {
        self.name = model.name ?? ""
        self.original = model.original ?? ""
    }
}
