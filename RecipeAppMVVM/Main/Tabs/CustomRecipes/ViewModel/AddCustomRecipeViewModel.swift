//
//  CustomRecipesViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 08/07/24.
//

import CoreData
import Foundation
import SwiftUI

class AddCustomRecipeViewModel: ObservableObject {
    private static let dishTypeTitles: [DishType] = [
        .breakfast, .appetizer, .salad, .lunch,
        .dessert, .snack, .dinner, .beverage
    ]
    
    private static let dietTitles: [Diet] = [
        .vegetarian, .vegan, .dairyFree, .glutenFree,
        .lactoOvoVegetarian, .pescatarian, .paleolithic, .ketogenic
    ]
    
    @Published private var hasUncommittedChanges = true
    
    @Published var showErrorAlert = false
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    
    @Published var showSaveSuccessAlert = false
    @Published var photo: UIImage?
    
    @Published var title = ""
    var hasValidTitle: Bool {
        hasUncommittedChanges || !title.isEmpty
    }
    
    @Published var servings = ""
    var hasValidServings: Bool {
        hasUncommittedChanges || !servings.isEmpty
    }
    
    @Published var readyInMinutes = ""
    var hasValidReadyInMinutes: Bool {
        hasUncommittedChanges || !readyInMinutes.isEmpty
    }
    
    @Published var dishTypeSelection: [(Bool, DishType)] = dishTypeTitles.map { (false, $0) }
    var hasValidDishType: Bool {
        hasUncommittedChanges || !dishTypeSelection.filter { $0.0 }.isEmpty
    }
    
    @Published var dietSelection: [(Bool, Diet)] = dietTitles.map { (false, $0) }
    var hasValidDiet: Bool {
        hasUncommittedChanges || !dietSelection.filter { $0.0 }.isEmpty
    }
    
    @Published var ingredients: [String] = []
    var hasValidIngredients: Bool {
        hasUncommittedChanges || !ingredients.isEmpty
    }
    
    @Published var instructions: [String] = []
    var hasValidInstructions: Bool {
        hasUncommittedChanges || !instructions.isEmpty
    }
    
    static func getDietList(using list: [Diet]) -> [(Bool, Diet)] {
        return dietTitles.map { (list.contains($0), $0) }
    }
    
    static func getDishTypeList(using list: [DishType]) -> [(Bool, DishType)] {
        return dishTypeTitles.map { (list.contains($0), $0) }
    }
}

extension AddCustomRecipeViewModel {
    func saveRecipe(
        recipeId: Int?,
        isFavorite: Bool,
        with context: NSManagedObjectContext
    ) {
        hasUncommittedChanges = false
        
        let stateList = [
            hasValidTitle,
            hasValidServings,
            hasValidReadyInMinutes,
            hasValidDishType,
            hasValidDiet,
            hasValidIngredients,
            hasValidInstructions
        ]
        
        let isValid = stateList.filter { !$0 }.isEmpty
        
        if isValid {
            do {
                if let recipeId {
                    try update(recipeId, isFavorite: isFavorite, with: context)
                } else {
                    try create(with: context)
                }
                
                showSaveSuccessAlert = true
            } catch {
                errorTitle = recipeId != nil ? "Error on recipe update!" : "Error on recipe creation!"
                errorMessage = "Please, try again later."
                showErrorAlert = true
            }
        } else {
            errorTitle = "Invalid recipe!"
            errorMessage = "It seems you custom recipe has empty fields. Please, fill them in."
            showErrorAlert = true
        }
    }
}

// MARK: - database functions
extension AddCustomRecipeViewModel {
    private func create(with context: NSManagedObjectContext) throws {
        let ingredientList = ingredients.map { Ingredient(original: $0) }
        let instructionList = Instruction(steps: instructions.enumerated().map { Step($0.0, $0.1) })
        let dishTypeList = dishTypeSelection.filter { $0.0 }.map { $0.1 }
        let dietList = dietSelection.filter { $0.0 }.map { $0.1 }
        
        try CustomRecipeDataModel.createRecipe(
            title: title,
            image: photo?.pngData()?.base64EncodedString(),
            servings: Int(servings) ?? 1,
            readyInMinutes: Int(readyInMinutes) ?? 1,
            ingredients: ingredientList,
            instructions: instructionList,
            dishTypes: dishTypeList,
            diets: dietList,
            with: context
        )
    }
    
    private func update(
        _  id: Int?,
        isFavorite: Bool,
        with context: NSManagedObjectContext
    ) throws {
        guard let id else { return }
        
        let ingredientList = ingredients.map { Ingredient(original: $0) }
        let instructionList = Instruction(steps: instructions.enumerated().map { Step($0.0, $0.1) })
        let dishTypeList = dishTypeSelection.filter { $0.0 }.map { $0.1 }
        let dietList = dietSelection.filter { $0.0 }.map { $0.1 }
        
        try CustomRecipeDataModel.updateRecipe(
            id: id,
            title: title,
            image: photo?.pngData()?.base64EncodedString(),
            servings: Int(servings) ?? 1,
            readyInMinutes: Int(readyInMinutes) ?? 1,
            ingredients: ingredientList,
            instructions: instructionList,
            dishTypes: dishTypeList,
            diets: dietList,
            isFavorite: isFavorite,
            with: context
        )
    }
}
