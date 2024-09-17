//
//  CategoriesTabOptions.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

import Foundation

enum CategoriesTabOptions: Int, Identifiable, CaseIterable {
    case dishType = 0
    case diet = 1
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .dishType:
            return "Dish type"
        case .diet:
            return "Diet"
        }
    }
}
