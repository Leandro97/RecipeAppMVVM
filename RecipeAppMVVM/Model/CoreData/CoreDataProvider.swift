//
//  CoreDataProvider.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 16/04/24.
//

import CoreData
import Foundation

struct CoreDataProvider {
    static var shared = CoreDataProvider()
    
    /// A persistent container to set up the Core Data stack.
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Database")

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

enum Entity: CaseIterable {
    case customRecipe
    case favoriteRecipe
    case diet
    case dishType
    case ingredient
    case instruction
    case recipeDiet
    case recipeDishType
    
    var name: String {
        switch self {
        case .customRecipe:
            CustomRecipeDataModel.identifier
        case .favoriteRecipe:
            FavoriteRecipeDataModel.identifier
        case .diet:
            DietDataModel.identifier
        case .dishType:
            DishTypeDataModel.identifier
        case .ingredient:
            IngredientDataModel.identifier
        case .instruction:
            InstructionDataModel.identifier
        case .recipeDiet:
            RecipeDietDataModel.identifier
        case .recipeDishType:
            RecipeDishTypeDataModel.identifier
        }
    }
}
