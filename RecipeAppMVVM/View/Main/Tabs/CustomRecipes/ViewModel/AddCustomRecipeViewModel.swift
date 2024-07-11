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
}

extension AddCustomRecipeViewModel {
    func saveRecipe(with context: NSManagedObjectContext) {
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
            let ingredientList = ingredients.map { Ingredient(original: $0) }
            let instructionList = Instruction(steps: instructions.map { Step($0) })
            let dishTypeList = dishTypeSelection.filter { $0.0 }.map { $0.1 }
            let dietList = dietSelection.filter { $0.0 }.map { $0.1 }
            
            do {
                try CustomRecipeDataModel.addRecipe(
                    title: title,
                    image: photo?.pngData()?.base64EncodedString(),
                    servings: Int(servings) ?? 1,
                    readyInMinutes: Int(readyInMinutes) ?? 1,
                    ingredients: ingredientList,
                    instruction: instructionList,
                    dishTypes: dishTypeList,
                    diets: dietList,
                    with: context
                )
                
                showSaveSuccessAlert = true
            } catch {
                errorTitle = "Error on recipe creation!"
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
