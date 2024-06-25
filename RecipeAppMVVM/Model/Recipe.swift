//
//  Recipe.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct RecipeList: Decodable, Equatable {
    let recipes: [Recipe]
    
    static func == (lhs: RecipeList, rhs: RecipeList) -> Bool {
        lhs.recipes == rhs.recipes
    }
}

struct Recipe: Decodable, Identifiable, Equatable {
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let readyInMinutes: Int
    let extendedIngredients: [Ingredient]
    let analyzedInstructions: [Instruction]
    let dishTypes: [DishType] // https://spoonacular.com/food-api/docs#Meal-Types
    let sourceUrl: String
    let diets: [Diet]
    
    init(id: Int) {
        self.id = id
        self.title = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        self.image = "https://spoonacular.com/recipeImages/716429-556x370.jpg"
        self.servings = 2
        self.readyInMinutes = 30
        self.extendedIngredients = [.init(), .init(), .init()]
        self.analyzedInstructions = .init()
        self.dishTypes = [.breakfast, .mainCourse]
        self.sourceUrl = "http://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html"
        self.diets = []
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
