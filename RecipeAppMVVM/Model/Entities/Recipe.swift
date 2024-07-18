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
    let diets: [Diet]
    
    var isCustom: Bool {
        return id < 0
    }
    
    init(id: Int) {
        self.id = id
        self.title = "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs"
        self.image = "https://spoonacular.com/recipeImages/716429-556x370.jpg"
        self.servings = 2
        self.readyInMinutes = 30
        self.extendedIngredients = [.init(), .init(), .init()]
        self.analyzedInstructions = .init()
        self.dishTypes = [.breakfast, .mainCourse]
        self.diets = []
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.image == rhs.image &&
        lhs.servings == rhs.servings &&
        lhs.readyInMinutes == rhs.readyInMinutes &&
        lhs.extendedIngredients == rhs.extendedIngredients &&
        lhs.analyzedInstructions == rhs.analyzedInstructions &&
        lhs.dishTypes == rhs.dishTypes &&
        lhs.diets == rhs.diets
    }
}

extension Recipe {
    init(with model: CustomRecipeDataModel) {
        self.id = Int(model.recipeId)
        self.title = model.title ?? ""
        self.image = model.image ?? ""
        self.servings = Int(model.servings)
        self.readyInMinutes = Int(model.readyInMinutes)
        self.extendedIngredients = Self.getIngredients(model.ingredients)
        self.analyzedInstructions = Self.getInstructions(model.instructions)
        self.dishTypes = Self.getDishTypes(model.dishTypes)
        self.diets = Self.getDiets(model.diets)
    }
    
    private static func getIngredients(_ objects: NSSet?) -> [Ingredient] {
        guard let objects = objects else { return [] }
        
        let list = objects.allObjects as! [IngredientDataModel]
        return list.map { Ingredient(with: $0) }
    }
    
    private static func getInstructions(_ objects: NSSet?) -> [Instruction] {
        guard let objects = objects else { return [] }
        
        let list = objects.allObjects as! [InstructionDataModel]
        return [Instruction(with: list)]
    }
    
    private static func getDishTypes(_ objects: NSSet?) -> [DishType] {
        guard let objects = objects else { return [] }
        
        let list = objects.allObjects as! [RecipeDishTypeDataModel]
        return list.map { DishType(with: $0) }
    }
    
    private static func getDiets(_ objects: NSSet?) -> [Diet] {
        guard let objects = objects else { return [] }
        
        let list = objects.allObjects as! [RecipeDietDataModel]
        return list.map { Diet(with: $0) }
    }
}
