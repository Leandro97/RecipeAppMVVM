//
//  TabBar.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesTabView()
                .tabItem {
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
            
            
            NewRecipeTabView()
                .tabItem {
                    Label("New Recipe", systemImage: "plus")
                }
            
            FavoritesTabView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            SettingsTabView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
