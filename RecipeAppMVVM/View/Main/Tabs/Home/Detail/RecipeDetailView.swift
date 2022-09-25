//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(with recipe: Recipe) {
        self.viewModel = ViewModel(with: recipe)
    }
    
    var body: some View {
        ScrollView {
            RecipeDetailHeaderView(image: viewModel.state.image)
            
            VStack(spacing: 30) {
                Text(viewModel.state.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if !viewModel.state.extendedIngredients.isEmpty {
                    Group {
                        Text("Ingredients")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.getIngredientList())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if !viewModel.state.instructions.isEmpty {
                    Group {
                        Text("Instructions")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.getInstructionList())
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
    
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(with: Recipe(id: 0))
    }
}
