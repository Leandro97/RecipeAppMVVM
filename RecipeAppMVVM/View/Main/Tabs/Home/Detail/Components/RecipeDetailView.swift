//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject private var viewModel: RecipeDetailViewModel
    
    init(with recipe: Recipe) {
        self.viewModel = .init(with: recipe)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    RecipeDetailHeaderView(image: viewModel.recipe.image)
                    
                    VStack(spacing: 16) {
                        Text(viewModel.recipe.title)
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        if !viewModel.recipe.extendedIngredients.isEmpty {
                            VStack(spacing: 16) {
                                Text("Ingredients")
                                    .bold()
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(
                                        Array(
                                            zip(
                                                viewModel.ingredientList.indices,
                                                viewModel.ingredientList
                                            )
                                        ),
                                        id: \.0
                                    ) { index, ingredient in
                                        
                                        HStack(spacing: 16) {
                                            StepBadge(order: index + 1)
                                                .frame(alignment: .leading)
                                            
                                            Text(ingredient)
                                                .frame(alignment: .trailing)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        
                        if !viewModel.recipe.steps.isEmpty {
                            VStack(spacing: 16) {
                                Text("Instructions")
                                    .bold()
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    ForEach(
                                        Array(
                                            zip(
                                                viewModel.stepList.indices,
                                                viewModel.stepList
                                            )
                                        ),
                                        id: \.0
                                    ) { index, step in
                                        HStack(spacing: 16) {
                                            StepBadge(order: index + 1)
                                                .frame(alignment: .leading)
                                            
                                            Text(step)
                                                .frame(alignment: .trailing)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: geometry.size.width)
            }
            .padding(.bottom, 16)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(with: Recipe(id: 0))
    }
}
