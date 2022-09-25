//
//  CategoriesTab.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import SwiftUI

struct CategoriesTabView: View {
    var screenTitle = "Categories"
    
    var body: some View {
        NavigationView {
            Text(screenTitle)
                .navigationTitle(screenTitle)
        }
        .navigationViewStyle(.stack)
    }
}

struct CategoriesTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTabView()
    }
}
