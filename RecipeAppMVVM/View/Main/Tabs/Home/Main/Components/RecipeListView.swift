//
//  RecipeListView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeListView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    let sectionTitle = viewModel.recipeList.count == 1 ? "recipe" : "recipes"
                    
                    Text("\(viewModel.recipeList.count) \(sectionTitle)")
                        .font(.headline)
                        .fontWeight(.medium)
                        .opacity(0.7)
                    
                    Spacer()
                }
                
                let gridItemList = [
                    GridItem(
                        .adaptive(minimum: 160), spacing: 15
                    )
                ]
                
                LazyVGrid(columns: gridItemList, spacing: 15) {
                    ForEach(viewModel.recipeList) { recipe in
                        NavigationLink(destination: RecipeDetailView(with: recipe)) {
                            RecipeCard(recipe: recipe)
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .task { await viewModel.getRandomRecipes() }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
