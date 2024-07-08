//
//  AddCustomRecipeView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import SwiftUI

struct AddCustomRecipeView {
    @StateObject private var viewModel = AddCustomRecipeViewModel()
}

//image: String?,

extension AddCustomRecipeView: View {
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    Text("New recipe")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(6)
                }
                
                Section {
                    TextField("Recipe title", text: $viewModel.title)
                        .validate(viewModel.hasValidTitle)
                    
                    TextField("Servings", text: $viewModel.servings)
                        .keyboardType(.numberPad)
                        .validate(viewModel.hasValidServings)
                    
                    TextField("Preparation time (in minutes)", text: $viewModel.readyInMinutes)
                        .keyboardType(.numberPad)
                        .validate(viewModel.hasValidReadyInMinutes)
                }
                
                Section {
                    Button {
                        // TODO: - open camera
                    } label: {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .padding(6)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                Section {
                    Text("Dish type(s)")
                        .font(.title2)
                        .padding(6)
                        .validate(viewModel.hasValidDishType)
                    
                    ScrollViewSelectionView(list: $viewModel.dishTypeSelection)
                }
                
                Section {
                    Text("Diet(s)")
                        .font(.title2)
                        .padding(6)
                        .validate(viewModel.hasValidDiet)
                    
                    ScrollViewSelectionView(list: $viewModel.dietSelection)
                }
                
                Section {
                    Text("Ingredients")
                        .font(.title2)
                        .padding(6)
                    
                    TextFieldListView(
                        values: $viewModel.ingredients,
                        placeHolder: "e.g. 1 tbsp of butter",
                        hasOrderedValues: false
                    )
                    .validate(viewModel.hasValidIngredients)
                }
                
                Section {
                    Text("Instructions")
                        .font(.title2)
                        .padding(6)
                    
                    TextFieldListView(
                        values: $viewModel.instructions,
                        placeHolder: "e.g. add the flour to batter. Stir and let it sit for 20 minutes.",
                        hasOrderedValues: true
                    )
                    .validate(viewModel.hasValidInstructions)
                }
            }
            
            Text("Save")
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(12)
                .onTapGesture {
                    viewModel.saveRecipe()
                }
                .padding(24)
        }
        .alert(isPresented: $viewModel.showInvalidFieldsAlert) {
            Alert(
                title: Text("Invalid recipe!"),
                message: Text("It seems you custom recipe has empty fields. Please, fill them in."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    AddCustomRecipeView()
}
