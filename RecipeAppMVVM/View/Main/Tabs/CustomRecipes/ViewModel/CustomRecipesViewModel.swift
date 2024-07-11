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
    @Published var showInvalidFieldsAlert = false
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
    
    @Published var dishTypeSelection: [(Bool, String)] = dishTypeTitles.map { (false, $0.categoryTitle) }
    var hasValidDishType: Bool {
        hasUncommittedChanges || !dishTypeSelection.filter { $0.0 }.isEmpty
    }
    
    @Published var dietSelection: [(Bool, String)] = dietTitles.map { (false, $0.rawValue.capitalized) }
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
    func saveRecipe() {
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
            // TODO: - save recipe on database
        } else {
            showInvalidFieldsAlert = true
        }
    }
}
