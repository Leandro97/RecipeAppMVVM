//
//  AddCustomRecipeView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct AddCustomRecipeView {
    @SwiftUI.State private var title = ""
    @SwiftUI.State private var servings = ""
    @SwiftUI.State private var readyInMinutes = ""
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
                }
                .padding(.horizontal, 32)
            }
        }
    }
}

#Preview {
    AddCustomRecipeView()
}
