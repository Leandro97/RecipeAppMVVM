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
}

//image: String?,
//ingredients: [Ingredient],
//instruction: Instruction,
//dishTypes: [DishType],
//diets: [Diet],

extension AddCustomRecipeView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("New recipe")
                    .font(.title)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding([.leading, .bottom], 32)
            .padding(.top, -32)
            
            ScrollView {
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Title",
                        value: $title
                    )
                    
                    CustomTextField(
                        title: "Servings",
                        keyboardType: .numberPad,
                        value: $servings
                    )
                    
                    CustomTextField(
                        title: "Preparation time (in minutes)",
                        keyboardType: .numberPad,
                        value: $readyInMinutes
                    )
                    
                    ScrollViewSelectionView(title: "Dish type(s)", list: $dishTypeSelection)
                        .padding(.horizontal, -32)
                    
                    ScrollViewSelectionView(title: "Diet(s)", list: $dietSelection)
                        .padding(.horizontal, -32)
                }
                .padding(.horizontal, 32)
                .padding(.top, 2)
            }
        }
    }
}

#Preview {
    AddCustomRecipeView()
}
