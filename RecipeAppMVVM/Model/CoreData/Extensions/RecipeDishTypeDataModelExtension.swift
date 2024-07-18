//
//  RecipeDishTypeDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/05/24.
//

import CoreData
import Foundation

extension RecipeDishTypeDataModel {
    static var identifier: String { String(describing: self) }
    
    static func create(
        _ dishTypes: [DishType],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        for object in dishTypes {
            let model = createModel(for: object, with: recipe, and: context)
            recipe.addToDishTypes(model)
        }
    }
    
    static func update(
        _ dishTypes: [DishType],
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        let currentDishTypes = recipe.dishTypes?.allObjects as? [RecipeDishTypeDataModel] ?? []
        
        for dishType in currentDishTypes {
            recipe.removeFromDishTypes(dishType)
        }
        
        for object in dishTypes {
            let model = createModel(for: object, with: recipe, and: context)
            recipe.addToDishTypes(model)
        }
    }
    
    private static func createModel(
        for object: DishType,
        with recipe: CustomRecipeDataModel,
        and context: NSManagedObjectContext
    ) -> RecipeDishTypeDataModel {
        // TODO: - add dish types on installation
        let dishTypeModel = DishTypeDataModel(context: context)
        dishTypeModel.dishTypeId = object.rawValue
        
        let relationModel = RecipeDishTypeDataModel(context: context)
        relationModel.recipe = recipe
        relationModel.dishType = dishTypeModel
        
        return relationModel
    }
}
