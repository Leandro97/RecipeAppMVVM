//
//  AddCustomRecipeView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 05/07/24.
//

import PhotosUI
import SwiftUI

struct AddCustomRecipeView {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var isPresented
    @StateObject private var viewModel = AddCustomRecipeViewModel()
    @FocusState private var focusField
    @State private var selectedTextField: Int?
    @State private var openCamera = false
}

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
                        .focused($focusField)
                        .validate(viewModel.hasValidServings)
                        .toolbar {
                            if selectedTextField == 1 {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        selectedTextField = nil
                                        focusField = false
                                    }
                                }
                            }
                        }
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                selectedTextField = 1
                            }
                        )
                    
                    TextField("Preparation time (in minutes)", text: $viewModel.readyInMinutes)
                        .keyboardType(.numberPad)
                        .focused($focusField)
                        .validate(viewModel.hasValidReadyInMinutes)
                        .toolbar {
                            if selectedTextField == 2 {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        selectedTextField = nil
                                        focusField = false
                                    }
                                }
                            }
                        }
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                selectedTextField = 2
                            }
                        )
                }
                
                Section {
                    Button {
                        #if targetEnvironment(simulator)
                        viewModel.photo = UIImage(systemName: "text.below.photo")
                        #else
                        openCamera = true
                        #endif
                    } label: {
                        if let photo = viewModel.photo {
                            ZStack {
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 217)
                                    .cornerRadius(16)
                                
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                            }
                        } else {
                            Image(systemName: "camera.circle")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .padding(6)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .fullScreenCover(isPresented: $openCamera) {
                        CameraView(selectedImage: $viewModel.photo)
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
                
                Section {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                        .onTapGesture {
                            viewModel.saveRecipe(with: context)
                        }
                }
            }
        }
        .alert(
            viewModel.errorTitle,
            isPresented: $viewModel.showErrorAlert,
            actions: {
                Button("OK") {}
            },
            message: {
                Text(viewModel.errorMessage)
            }
        )
        .alert(
            "Recipe saved successfully!",
            isPresented: $viewModel.showSaveSuccessAlert,
            actions: {
                Button("OK") {
                    self.isPresented.wrappedValue.dismiss()
                }
            }
        )
        
    }
}

#Preview {
    AddCustomRecipeView()
}
