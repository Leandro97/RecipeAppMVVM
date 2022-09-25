//
//  NewRecipeTabView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct NewRecipeTabView: View {
    var screenTitle = "New Recipe"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct NewRecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeTabView()
    }
}
