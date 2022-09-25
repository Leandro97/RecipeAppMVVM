//
//  RecipeServiceProtocol.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 23/07/22.
//

import Foundation

protocol RecipeServiceProtocol {
    func getRandomRecipes() async -> [Recipe]
}

extension RecipeServiceProtocol {
    var getRandomRecipesUrl: String { "recipes/random?apiKey=\(BaseUrl.apiKey)&number=6" }
    var searchRecipesUrl: String { "" }
}
