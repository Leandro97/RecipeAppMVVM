//
//  RecipeService.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

final class RecipeService: RecipeServiceProtocol {
    func getRandomRecipes() async -> [Recipe] {
        let urlString = BaseUrl.domain + self.getRandomRecipesUrl
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let entity = try JSONDecoder().decode(RecipeList.self, from: data)
            return entity.recipes
        } catch {
            return []
        }
    }
}
