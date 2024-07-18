//
//  IngredientDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/05/24.
//

import CoreData
import Foundation

extension IngredientDataModel {
    static var identifier: String { String(describing: self) }
    
    static func create(
        _ ingredients: [Ingredient],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        for (index, object) in ingredients.enumerated() {
            let model = createModel(for: object, with: index, and: context)
            recipe.addToIngredients(model)
        }
    }
    
    static func update(
        _ ingredients: [Ingredient],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        let currentIngredients = recipe.ingredients?.allObjects as? [IngredientDataModel] ?? []
        
        for ingredient in currentIngredients {
            recipe.removeFromIngredients(ingredient)
        }
        
        for (index, object) in ingredients.enumerated() {
            let model = createModel(for: object, with: index, and: context)
            recipe.addToIngredients(model)
        }
    }
    
    private static func createModel(
        for object: Ingredient,
        with index: Int,
        and context: NSManagedObjectContext
    ) -> IngredientDataModel {
        let model = IngredientDataModel(context: context)
        model.number = Int64(index)
        model.original = object.original
        return model
    }
}
