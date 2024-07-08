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
    
    @Published var title = ""
    @Published var hasValidTitle = true
    
    @Published var servings = ""
    @Published var hasValidServings = true
    
    @Published var readyInMinutes = ""
    @Published var hasValidReadyInMinutes = true
    
    @Published var dishTypeSelection: [(Bool, String)] = dishTypeTitles.map { (false, $0.categoryTitle) }
    @Published var hasValidDishType = true
    
    @Published var dietSelection: [(Bool, String)] = dietTitles.map { (false, $0.rawValue.capitalized) }
    @Published var hasValidDiet = true
    
    @Published var ingredients: [String] = []
    @Published var hasValidIngredients = true
    
    @Published var instructions: [String] = []
    @Published var hasValidInstructions = true
}

extension AddCustomRecipeViewModel {
    func saveRecipe() {
        hasValidTitle = !title.isEmpty
        hasValidServings = !servings.isEmpty
        hasValidReadyInMinutes = !readyInMinutes.isEmpty
        hasValidDishType = !dishTypeSelection.filter { $0.0 }.isEmpty
        hasValidDiet = !dietSelection.filter { $0.0 }.isEmpty
        hasValidIngredients = !ingredients.isEmpty
        hasValidInstructions = !instructions.isEmpty
        
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
            // TODO: - save recipe on database
        }
    }
}
