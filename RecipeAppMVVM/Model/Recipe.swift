//
//  Recipe.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String
    let extendedIngredients: [Ingredient]
    let instructions: String
    let dishTypes: [String] //[DishType]
    let sourceUrl: String
    
    init() {
        self.id = 716429
        self.title = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        self.image = "https://spoonacular.com/recipeImages/716429-556x370.jpg"
        self.extendedIngredients = []
        self.instructions = ""
        self.dishTypes = []
        self.sourceUrl = "http://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html"
    }
}
