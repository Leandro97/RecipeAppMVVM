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
            HomeTab()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CategoriesTab()
                .tabItem {
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
            
            
            NewRecipeTab()
                .tabItem {
                    Label("New Recipe", systemImage: "plus")
                }
            
            FavoritesTab()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            SettingsTab()
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
