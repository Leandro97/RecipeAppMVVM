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
            let model = createModel(for: object, with: recipe, and: context)
            recipe.addToDiets(model)
        }
    }
    
    static func update(
        _ diets: [Diet],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        let currentDiets = recipe.diets?.allObjects as? [RecipeDietDataModel] ?? []
        
        for diet in currentDiets {
            recipe.removeFromDiets(diet)
        }
        
        for object in diets {
            let model = createModel(for: object, with: recipe, and: context)
            recipe.addToDiets(model)
        }
    }
    
    private static func createModel(
        for object: Diet,
        with recipe: CustomRecipeDataModel,
        and context: NSManagedObjectContext
    ) -> RecipeDietDataModel {
        // TODO: - add diets on installation
        let dietModel = DietDataModel(context: context)
        dietModel.dietId = object.rawValue
        
        let relationModel = RecipeDietDataModel(context: context)
        relationModel.recipe = recipe
        relationModel.diet = dietModel
        
        return relationModel
    }
}
