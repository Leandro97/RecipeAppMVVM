//
//  RecipeListViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation


extension RecipeListView {
    class ViewModel: ObservableObject {
        private let service = RecipeService()
        @Published private(set) var recipeList = [Recipe]()
        
        func getRandomRecipes() async {
            self.recipeList = await service.getRandomRecipes()
        }
    }
}
