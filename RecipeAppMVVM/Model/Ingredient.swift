//
//  Ingredient.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Ingredient: Decodable {
    let id: Int
    let name: String
    let original: String
    
    // TODO: - Remove
    init() {
        self.id = 1
        self.name = "butter"
        self.original = "1 tbsp of butter"
    }
}
