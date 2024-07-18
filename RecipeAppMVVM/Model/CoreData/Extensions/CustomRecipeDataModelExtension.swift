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
    
    static func addRecipe(
        title: String,
        image: String?,
        servings: Int,
        readyInMinutes: Int,
        ingredients: [Ingredient],
        instruction: Instruction,
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
        set(ingredients, for: recipe, with: context)
        set(instruction, for: recipe, with: context)
        set(dishTypes, for: recipe, with: context)
        set(diets, for: recipe, with: context)
        
        try context.save()
    }
    
    static func getRecipe(with id: Int, and context: NSManagedObjectContext) -> CustomRecipeDataModel? {
        let request = CustomRecipeDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "recipeId == %i", Int64(id))
        
        let objects = try? context.fetch(request)
        return objects?.first
    }
}

// MARK: - Utils
extension CustomRecipeDataModel {
    private static func set(
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
    
    private static func set(
        _ instruction: Instruction,
        for recipe: CustomRecipeDataModel,
        with context: NSManagedObjectContext
    ) {
        for object in instruction.steps {
            let model = InstructionDataModel(context: context)
            model.number = Int64(object.number)
            model.step = object.step
            
            recipe.addToInstructions(model)
        }
    }
    
    private static func set(
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
    
    private static func set(
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
}
