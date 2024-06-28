//
//  CategoriesListViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import Foundation
import SwiftUI

class CategoriesListViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published private(set) var recipeList = [Recipe]()
    @Published var isLoading = false
    @Published var hasError = false
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
}

extension CategoriesListViewModel {
    @MainActor func getRandomRecipes(with dishType: DishType?, and diet: Diet?) async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipeList = try await service.getRandomRecipes(quantity: 8, dishType: dishType, diet: diet)
        } catch {
            self.hasError = true
        }
    }
}
