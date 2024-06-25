//
//  HomeViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published private(set) var recipeList = [Recipe]()
    @Published var isLoading = false
    @Published var hasError = false
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
}

extension HomeViewModel {
    @MainActor func getRandomRecipes() async {
        // TODO: - get recipes using device time (breakfast, lunch, snack, dinner, etc..)
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipeList = try await service.getRandomRecipes(quantity: 8)
        } catch {
            self.hasError = true
        }
    }
}
