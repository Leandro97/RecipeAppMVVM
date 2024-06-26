//
//  DishType.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 01/03/22.
//

import Foundation

enum DishType: String, Decodable, Identifiable {
    case dessert, appetizer, salad, bread, dinner, breakfast, soup, beverage, sauce, snack, lunch
    case mainCourse = "main course"
    case sideDish = "side dish"
    case unknown
    
    var id: Self { self }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = DishType(rawValue: string) ?? .unknown
    }
}
