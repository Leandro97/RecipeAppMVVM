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
}
