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
            // TODO: - add dish types on installation
            let dishTypeModel = DishTypeDataModel(context: context)
            dishTypeModel.dishTypeId = object.rawValue
            
            let relationModel = RecipeDishTypeDataModel(context: context)
            relationModel.recipe = recipe
            relationModel.dishType = dishTypeModel
            
            recipe.addToDishTypes(relationModel)
        }
    }
}
