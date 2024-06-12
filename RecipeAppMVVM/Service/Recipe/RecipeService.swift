//
//  RecipeService.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

final class RecipeService: RecipeServiceProtocol {
    func getRandomRecipes(quantity: Int) async throws -> [Recipe] {
        let recipe = try await RequestBuilder.makeRequest(
            method: .get,
            endpoint: self.getRandomRecipesUrl,
            queryParameters: [.init(name: "number", value: "\(quantity)")],
            using: RecipeList.self
        )
        
        return recipe.recipes
    }
    
    func getSimilarRecipe(with id: Int) async throws -> Recipe {
        let endpoint = String(format: self.getSimilarRecipeUrl, String(id))
        let quantity = Int.random(in: 2...15)
        
        let recipeList = try await RequestBuilder.makeRequest(
            method: .get,
            endpoint: endpoint,
            queryParameters: [.init(name: "number", value: "\(quantity)")],
            using: [SimilarRecipeObject].self
        )
        
        guard !recipeList.isEmpty else { throw HTTPRequestError.noContent }
        
        let endIndex = min(recipeList.count, quantity)
        let recipeIndex = Int.random(in: 0...endIndex-1)
        let recipe = recipeList[recipeIndex]
        
        return try await getRecipe(with: recipe.id)
    }
    
    func getRecipe(with id: Int) async throws -> Recipe {
        let endpoint = String(format: self.getRecipeInfoUrl, String(id))
        
        let recipe = try await RequestBuilder.makeRequest(
            method: .get,
            endpoint: endpoint,
            using: Recipe.self
        )
        
        return recipe
    }
}
