//
//  HomeTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct HomeTabView: View {
    var screenTitle = "My Recipes"
    
    // TODO: - Should allow user to see api recipes and custom recipes. Use switch? Tabs?
    var body: some View {
        NavigationView {
            RecipeListView().navigationTitle("My Recipes")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
