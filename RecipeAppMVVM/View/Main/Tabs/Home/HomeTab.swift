//
//  HomeTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct HomeTab: View {
    var screenTitle = "My Recipes"
    
    // TODO: - Should allow user to see api recipes and custom recipes. Use switch? Tabs?
    var body: some View {
        NavigationView {
            RecipeListView(
                recipeList: (1...5).enumerated().map {
                    (index, _) in Recipe(id: index)
                }
            )
                .navigationTitle("My Recipes")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
