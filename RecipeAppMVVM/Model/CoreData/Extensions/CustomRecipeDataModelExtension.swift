//
//  CustomRecipeDataModelExtension.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 02/05/24.
//

import CoreData
import Foundation

extension CustomRecipeDataModel {
    static var identifier: String { String(describing: self) }
    
    static var allCustomRecipes: NSFetchRequest<CustomRecipeDataModel> {
        let request = NSFetchRequest<CustomRecipeDataModel>(entityName: self.identifier)
        request.sortDescriptors = []
        return request
    }
    
    static func createRecipe(
        title: String,
        image: String?,
        servings: Int,
        readyInMinutes: Int,
        ingredients: [Ingredient],
        instructions: Instruction,
        dishTypes: [DishType],
        diets: [Diet],
        with context: NSManagedObjectContext
    ) throws {
        let recipe = CustomRecipeDataModel(context: context)
        let id = Int64.random(in: -999999999 ..< -1)
        recipe.recipeId = id
        recipe.title = title
        recipe.image = image
        recipe.servings = Int64(servings)
        recipe.readyInMinutes = Int64(readyInMinutes)
        
        IngredientDataModel.create(ingredients, for: recipe, with: context)
        InstructionDataModel.create(instructions, for: recipe, with: context)
        RecipeDishTypeDataModel.create(dishTypes, for: recipe, with: context)
        RecipeDietDataModel.create(diets, for: recipe, with: context)
        
        try context.save()
    }
    
    static func updateRecipe(
        id: Int,
        title: String,
        image: String?,
        servings: Int,
        readyInMinutes: Int,
        ingredients: [Ingredient],
        instructions: Instruction,
        dishTypes: [DishType],
        diets: [Diet],
        isFavorite: Bool,
        with context: NSManagedObjectContext
    ) throws {
        let request = CustomRecipeDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "recipeId == %i", Int64(id))
        
        guard
            let recipe = try? context.fetch(request).first
        else { throw NSError(domain: "Non existing recipe", code: 404) }
        
        recipe.setValue(title, forKey: "title")
        recipe.setValue(image, forKey: "image")
        recipe.setValue(servings, forKey: "servings")
        recipe.setValue(readyInMinutes, forKey: "readyInMinutes")
        
        IngredientDataModel.update(ingredients, for: recipe, with: context)
        InstructionDataModel.update(instructions, for: recipe, with: context)
        RecipeDishTypeDataModel.update(dishTypes, for: recipe, with: context)
        RecipeDietDataModel.update(diets, for: recipe, with: context)
        
        if isFavorite {
            FavoriteRecipeDataModel.update(
                id: id,
                title: title,
                image: image,
                with: context
            )
        }
        
        try context.save()
    }
    
    static func getRecipe(with id: Int, and context: NSManagedObjectContext) -> CustomRecipeDataModel? {
        let request = CustomRecipeDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "recipeId == %i", Int64(id))
        
        let objects = try? context.fetch(request)
        return objects?.first
    }
}
