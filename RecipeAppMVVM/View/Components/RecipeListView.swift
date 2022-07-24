//
//  RecipeListView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 06/03/22.
//

import SwiftUI

struct RecipeListView: View {
    var recipeList: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    let sectionTitle = recipeList.count == 1 ? "recipe" : "recipes"
                    
                    Text("\(recipeList.count) \(sectionTitle)")
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
                    ForEach(recipeList) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeCard(recipe: recipe)
                        }
                    }
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(
            recipeList: (1...5).enumerated().map {
                (index, recipe) in Recipe(id: index)
            }
        )
    }
}
