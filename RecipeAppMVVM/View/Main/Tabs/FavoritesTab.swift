//
//  FavoritesTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct FavoritesTab: View {
    var screenTitle = "Favorites"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTab()
    }
}
