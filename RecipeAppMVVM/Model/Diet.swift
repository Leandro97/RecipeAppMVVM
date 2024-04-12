//
//  Diet.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/04/24.
//

import Foundation

enum Diet: String, Decodable {
    case pescatarian, vegetarian, vegan, paleolithic, ketogenic
    case dairyFree = "dairy free"
    case glutenFree = "gluten free"
    case lactoOvoVegetarian = "lacto ovo vegetarian"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = Diet(rawValue: string) ?? .unknown
    }
}
