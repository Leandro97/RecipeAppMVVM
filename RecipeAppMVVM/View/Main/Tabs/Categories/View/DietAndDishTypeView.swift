//
//  DietAndDishTypeView.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import SwiftUI

struct DietAndDishTypeView {
    var dishType: DishType?
    var diet: Diet?
    @StateObject private var viewModel = CategoriesListViewModel()
}

extension DietAndDishTypeView: View {
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
    DietAndDishTypeView()
}
