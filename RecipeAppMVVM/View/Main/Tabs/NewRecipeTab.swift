//
//  NewRecipeTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct NewRecipeTab: View {
    var screenTitle = "New Recipe"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeTab()
    }
}
