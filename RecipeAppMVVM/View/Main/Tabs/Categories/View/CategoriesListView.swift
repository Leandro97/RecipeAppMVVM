//
//  CategoriesListView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import SwiftUI

struct CategoriesListView {
    var dishType: DishType?
    var diet: Diet?
    @StateObject private var viewModel = CategoriesListViewModel()
}

extension CategoriesListView: View {
    var body: some View {
        if let diet {
            Text("Diet: \(diet.rawValue)")
        }
        
        if let dishType {
            Text("Dish Type: \(dishType.rawValue)")
        }
    }
}

#Preview {
    CategoriesListView()
}
