//
//  RecipeDetailView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 15/03/24.
//

import SwiftUI

struct RecipeDetailView {
    @ObservedObject private var viewModel: RecipeDetailViewModel
    private var recipe: Recipe
    
    init(with recipe: Recipe) {
        self.recipe = recipe
        self.viewModel = .init(with: recipe)
    }
}

extension RecipeDetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            List {
                RecipeDetailHeaderView(image: viewModel.recipe.image)
                    .listRowBackground(Color.clear)
                
                Section(header: Text("Ingredients")) {
                    ForEach(
                        Array(viewModel.ingredientList.enumerated()),
                        id: \.element
                    ) { index, ingredient in
                        HStack(alignment: .top, spacing: 16) {
                            Text("\(index + 1)")
                                .bold()
                                .frame(alignment: .leading)
                            
                            Text(ingredient)
                                .frame(alignment: .trailing)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                    }
                }
                
                if !viewModel.stepList.isEmpty {
                    Section(header: Text("Instructions")) {
                        ForEach(
                            Array(viewModel.stepList.enumerated()),
                            id: \.element
                        ) { index, step in
                            HStack(alignment: .top, spacing: 16) {
                                Text("\(index + 1)")
                                    .bold()
                                    .frame(alignment: .leading)
                                
                                Text(step)
                                    .frame(alignment: .trailing)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(with: .init(id: 0))
}
