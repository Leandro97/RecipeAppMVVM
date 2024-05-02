//
//  FavoritesTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import CoreData
import SwiftUI

struct FavoritesTabView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: FavoriteRecipeDataModel.allFavorites)
    private var favoriteRecipes: FetchedResults<FavoriteRecipeDataModel>
}

extension FavoritesTabView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        let sectionTitle = favoriteRecipes.count == 1 ? "recipe" : "recipes"
                        
                        Text("\(favoriteRecipes.count) \(sectionTitle)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .opacity(0.7)
                            .padding(.leading, 8)
                        
                        Spacer()
                    }
                    
                    let gridItemList = [
                        GridItem(
                            .adaptive(minimum: 160), spacing: 15
                        )
                    ]
                    
                    LazyVGrid(columns: gridItemList, spacing: 15) {
                        ForEach(favoriteRecipes) { recipe in
//                            NavigationLink(destination: RecipeDetailView(with: recipe)) {
                                RecipeCard(image: recipe.image ?? "", title: recipe.title ?? "")
//                            }
                        }
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
            }
                .navigationTitle("Favorite recipes")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTabView()
    }
}
