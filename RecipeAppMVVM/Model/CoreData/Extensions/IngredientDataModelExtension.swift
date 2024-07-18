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
            let model = IngredientDataModel(context: context)
            model.number = Int64(index)
            model.original = object.original
            
            recipe.addToIngredients(model)
        }
    }
}
