//
//  RecipeServiceProtocol.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 23/07/22.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRandomRecipes(quantity: Int) async throws -> [Recipe]
    
    func getSimilarRecipe(with id: Int) async throws -> Int
    
    func getRecipe(with id: Int) async throws -> Recipe
}

extension RecipeServiceProtocol {
    var getRandomRecipesUrl: String { "recipes/random" }
    var getSimilarRecipeUrl: String { "recipes/%@/similar" }
    var getRecipeInfoUrl: String { "recipes/%@/information" }
}
