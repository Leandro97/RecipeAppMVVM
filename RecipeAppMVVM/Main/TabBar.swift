//
//  TabBar.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

enum MainTabs: Int {
    case home = 1
    case categories = 2
    case customRecipes = 3
    case favorites = 4
    case settings = 5
}

struct TabBar {
    @Environment(\.managedObjectContext) private var context
    @State private var selectedTab: MainTabs = .home
}

extension TabBar: View {
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(MainTabs.home)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
                .tag(MainTabs.categories)
            
            CustomRecipesView()
                .tabItem {
                    Label("My Recipes", systemImage: "person.badge.plus")
                }
                .tag(MainTabs.customRecipes)
                .environment(\.managedObjectContext, context)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(MainTabs.favorites)
                .environment(\.managedObjectContext, context)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(MainTabs.settings)
                .environment(\.managedObjectContext, context)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
