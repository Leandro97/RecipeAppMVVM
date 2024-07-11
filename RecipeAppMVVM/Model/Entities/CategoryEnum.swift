//
//  CategoryEnum.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 11/07/24.
//

import Foundation

protocol CategoryEnum: RawRepresentable, Hashable {
    var categoryTitle: String { get set }
}
