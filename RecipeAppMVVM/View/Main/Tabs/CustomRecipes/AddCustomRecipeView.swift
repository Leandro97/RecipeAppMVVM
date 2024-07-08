//
//  AddCustomRecipeView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct AddCustomRecipeView {
    private static let dishTypeTitles: [DishType] = [
        .breakfast, .appetizer, .salad, .lunch,
        .dessert, .snack, .dinner, .beverage
    ]
    
    private static let dietTitles: [Diet] = [
        .vegetarian, .vegan, .dairyFree, .glutenFree,
        .lactoOvoVegetarian, .pescatarian, .paleolithic, .ketogenic
    ]
    
    @State private var title = ""
    @State private var servings = ""
    @State private var readyInMinutes = ""
    @State private var dishTypeSelection: [(Bool, String)] = dishTypeTitles.map { (false, $0.categoryTitle) }
    @State private var dietSelection: [(Bool, String)] = dietTitles.map { (false, $0.rawValue.capitalized) }
    @State private var ingredients: [String] = []
    @State private var instructions: [String] = []
}

//image: String?,
//instruction: Instruction,

extension AddCustomRecipeView: View {
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    Text("New recipe")
                        .font(.title)
                        .fontWeight(.medium)
                }
                
                Section {
                    TextField("Recipe title", text: $title)
                    
                    TextField("Servings", text: $servings)
                        .keyboardType(.numberPad)
                    
                    TextField("Preparation time (in minutes)", text: $readyInMinutes)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    ScrollViewSelectionView(title: "Dish type(s)", list: $dishTypeSelection)
                }
                
                Section {
                    ScrollViewSelectionView(title: "Diet(s)", list: $dietSelection)
                }
                
                Section {
                    Text("Ingredients")
                        .font(.title2)
                    
                    TextFieldListView(
                        values: $ingredients,
                        placeHolder: "e.g. 1 tbsp of butter",
                        hasOrderedValues: false
                    )
                }
                
                Section {
                    Text("Instructions")
                        .font(.title2)
                    
                    TextFieldListView(
                        values: $instructions,
                        placeHolder: "e.g. add the flour to batter. Stir and let it sit for 20 minutes.",
                        hasOrderedValues: true
                    )
                }
            }
        }
    }
}

#Preview {
    AddCustomRecipeView()
}
