//
//  HomeViewModel.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 25/09/22.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    private let service: RecipeServiceProtocol
    @Published var isLoading: Bool = false
    @Published private(set) var recipeList = [Recipe]()
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
}

extension HomeViewModel {
    func getRandomRecipes() async {
        // TODO: - get recipes using device time (breakfast, lunch, snack, dinner, etc..)
        self.isLoading = true
        defer { self.isLoading = false }
        
        do {
            self.recipeList = try await service.getRandomRecipes(quantity: 8)
            
        } catch {
            // TODO: - handle error
        }
    }
}
