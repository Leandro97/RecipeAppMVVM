//
//  CustomRecipesView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct CustomRecipesView {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var customRecipes: FetchedResults<CustomRecipeDataModel>
}

extension CustomRecipesView: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        HStack {
                            let sectionTitle = customRecipes.count == 1 ? "recipe" : "recipes"
                            
                            Text("\(customRecipes.count) \(sectionTitle)")
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
                            ForEach(customRecipes) { recipe in
                                NavigationLink(destination: RecipeDetailView(withCustomId: Int(recipe.recipeId))) {
                                    RecipeCard(image: recipe.image ?? "", title: recipe.title ?? "")
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink(destination: AddCustomRecipeView()) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
                .padding()
            }
            .navigationTitle("My recipes")
        }
    }
}

struct MyRecipesTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecipesView()
    }
}
