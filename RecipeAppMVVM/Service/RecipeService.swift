//
//  RecipeService.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

final class RecipeService: RecipeServiceProtocol {
    func getRandomRecipes(quantity: Int) async throws -> [Recipe] {
        let urlString = BaseUrl.domain + self.getRandomRecipesUrl + "&number=\(quantity)"
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
        
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200,
                response.statusCode <= 300
            else {
                throw CustomError.invalidStatusCode
            }
            
            let entity = try JSONDecoder().decode(RecipeList.self, from: data)
            return entity.recipes
        } catch {
            return []
        }
    }
    
    func getSimilarRecipe(with id: Int) async throws -> Recipe? {
        let quantity = Int.random(in: 2...15)
        let urlString = BaseUrl.domain + String(format: self.getSimilarRecipeUrl, String(id)) + "&number=\(quantity)"
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
        
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200,
                response.statusCode <= 300
            else {
                throw CustomError.invalidStatusCode
            }
            
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
        let urlString = BaseUrl.domain + String(format: self.getRecipeInfoUrl, String(id))
        guard let url = URL(string: urlString) else { return nil}
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
        
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200,
                response.statusCode <= 300
            else {
                throw CustomError.invalidStatusCode
            }
            
            let entity = try JSONDecoder().decode(Recipe?.self, from: data)
            return entity
        } catch {
            return nil
        }
    }
}
