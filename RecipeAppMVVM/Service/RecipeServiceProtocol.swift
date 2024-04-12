//
//  RecipeServiceProtocol.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 23/07/22.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRandomRecipes(quantity: Int) async throws -> [Recipe]
    
    func getSimilarRecipe(with id: Int) async throws -> Recipe?
    
    func getRecipe(with id: Int) async throws -> Recipe?
}

extension RecipeServiceProtocol {
    var getRandomRecipesUrl: String { "recipes/random?apiKey=\(BaseUrl.apiKey)" }
    var getSimilarRecipeUrl: String { "recipes/%@/similar?apiKey=\(BaseUrl.apiKey)" }
    var getRecipeInfoUrl: String { "recipes/%@/information?apiKey=\(BaseUrl.apiKey)" }
}
