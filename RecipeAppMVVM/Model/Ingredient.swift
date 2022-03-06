//
//  Ingredient.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

struct Ingredient: Decodable {
    let id: Int
    let name: String
    let meta: [String]
    let amount: Double
    let unit: String
}
