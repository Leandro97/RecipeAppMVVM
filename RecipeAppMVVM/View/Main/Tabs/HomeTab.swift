//
//  HomeTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct HomeTab: View {
    var screenTitle = "My Recipes"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
