//
//  RecipeService.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

final class RecipeService: RecipeServiceProtocol {
    func getRandomRecipes(quantity: Int) async throws -> [Recipe] {
        do {
            let data = try await RequestBuilder.makeRequest(
                method: .get,
                endpoint: self.getRandomRecipesUrl,
                queryParameters: [.init(name: "number", value: "\(quantity)")]
            )
            
            let entity = try JSONDecoder().decode(RecipeList.self, from: data)
            return entity.recipes
        } catch {
            return []
        }
    }
    
    func getSimilarRecipe(with id: Int) async throws -> Recipe? {
        let endpoint = String(format: self.getSimilarRecipeUrl, String(id))
        let quantity = Int.random(in: 2...15)
        
        do {
            let data = try await RequestBuilder.makeRequest(
                method: .get,
                endpoint: endpoint,
                queryParameters: [.init(name: "number", value: "\(quantity)")]
            )
            
            let list = try JSONDecoder().decode([SimilarRecipeObject].self, from: data)
            
            guard !list.isEmpty else { return nil }
            
            let endIndex = min(list.count, quantity)
            let recipeIndex = Int.random(in: 0...endIndex-1)
            let recipe = list[recipeIndex]
            
            return try? await getRecipe(with: recipe.id)
        } catch {
            return nil
        }
    }
    
    func getRecipe(with id: Int) async throws -> Recipe? {
        let endpoint = String(format: self.getRecipeInfoUrl, String(id))
        
        do {
            let data = try await RequestBuilder.makeRequest(
                method: .get,
                endpoint: endpoint
            )
            
            let entity = try JSONDecoder().decode(Recipe?.self, from: data)
            return entity
        } catch {
            return nil
        }
    }
}
