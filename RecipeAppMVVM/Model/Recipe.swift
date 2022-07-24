//
//  Recipe.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let extendedIngredients: [Ingredient]
    let instructions: [Instruction]
    let dishTypes: [DishType] // https://spoonacular.com/food-api/docs#Meal-Types
    let sourceUrl: String
    
    init(id: Int) {
        self.id = id
        self.title = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        self.image = "https://spoonacular.com/recipeImages/716429-556x370.jpg"
        self.extendedIngredients = [.init(), .init(), .init()]
        self.instructions = [.init(), .init(), .init()]
        self.dishTypes = [.breakfast, .mainCourse]
        self.sourceUrl = "http://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html"
    }
}
