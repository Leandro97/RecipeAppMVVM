//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            RecipeDetailHeaderView(recipe: recipe)
            
            VStack(spacing: 30) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if !recipe.extendedIngredients.isEmpty {
                    Group {
                        Text("Ingredients")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(getIngredientList())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if !recipe.instructions.isEmpty {
                    Group {
                        Text("Instructions")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(getInstructionList())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.leading, 32)
            .padding(.trailing, 32)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private func getIngredientList() -> String {
        var text = ""
        recipe.extendedIngredients.enumerated().forEach { (index, value) in
            text += "\(index + 1) - \(value.original)\n"
        }
        return text
    }
    
    private func getInstructionList() -> String {
        var text = ""
        recipe.instructions.enumerated().forEach { (index, value) in
            text += "\(index + 1) - \(value.step)\n"
        }
        return text
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(id: 0))
    }
}
