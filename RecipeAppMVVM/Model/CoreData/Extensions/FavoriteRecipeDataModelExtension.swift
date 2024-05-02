//
//  FavoriteRecipeDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/05/24.
//

import CoreData
import Foundation

extension FavoriteRecipeDataModel {
    static var identifier: String { String(describing: self) }
    
    static var allFavorites: NSFetchRequest<FavoriteRecipeDataModel> {
        let request = NSFetchRequest<FavoriteRecipeDataModel>(entityName: self.identifier)
        request.sortDescriptors = []
        return request
    }
    
    static func setAsFavorite(
        _ recipe: Recipe,
        with context: NSManagedObjectContext,
        isCustom: Bool
    ) {
        let favorite = FavoriteRecipeDataModel(context: context)
        favorite.recipeId = Int64(recipe.id)
        favorite.title = recipe.title
        favorite.image = recipe.image
        favorite.isCustom = isCustom
        
        do {
            try context.save()
        } catch {
            // TODO
        }
    }
    
    static func deleteFavorite(
        _ recipe: Recipe,
        with context: NSManagedObjectContext
    ) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.identifier)
        let predicate = NSPredicate(format: "recipeId == %i", Int64(recipe.id))
        request.predicate = predicate
        
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            try context.executeAndMergeChanges(using: deleteRequest)
        } catch {
            // TODO
        }
    }
}
