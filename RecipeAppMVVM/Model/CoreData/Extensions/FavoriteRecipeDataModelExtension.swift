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
    
    static func create(
        _ recipe: Recipe,
        with context: NSManagedObjectContext
    ) throws {
        let favorite = FavoriteRecipeDataModel(context: context)
        favorite.recipeId = Int64(recipe.id)
        favorite.title = recipe.title
        favorite.image = recipe.image
        favorite.isCustom = recipe.isCustom
        
        try context.save()
    }
    
    static func update(
        id recipeId: Int,
        title: String,
        image: String?,
        with context: NSManagedObjectContext
    ) throws {
        let request = FavoriteRecipeDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "recipeId == %i", Int64(recipeId))
        
        guard
            let recipe = try? context.fetch(request).first
        else { throw NSError(domain: "Non existing recipe", code: 404) }
        
        recipe.title = title
        recipe.image = image
    }
    
    static func delete(
        _ recipe: Recipe,
        with context: NSManagedObjectContext
    ) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.identifier)
        let predicate = NSPredicate(format: "recipeId == %i", Int64(recipe.id))
        request.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.executeAndMergeChanges(using: deleteRequest)
    }
}
