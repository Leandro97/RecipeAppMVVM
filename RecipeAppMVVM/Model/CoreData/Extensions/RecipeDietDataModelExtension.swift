//
//  RecipeDietDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/05/24.
//

import CoreData
import Foundation

extension RecipeDietDataModel {
    static var identifier: String { String(describing: self) }
    
    static func create(
        _ diets: [Diet],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        for object in diets {
            // TODO: - add diets on installation
            let dietModel = DietDataModel(context: context)
            dietModel.dietId = object.rawValue
            
            let relationModel = RecipeDietDataModel(context: context)
            relationModel.recipe = recipe
            relationModel.diet = dietModel
            
            recipe.addToDiets(relationModel)
        }
    }
    
    static func update(
        _ diets: [Diet],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        // TODO
    }
}
