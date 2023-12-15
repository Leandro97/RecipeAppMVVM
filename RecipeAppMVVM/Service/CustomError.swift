//
//  CustomError.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 13/12/23.
//

import Foundation

public enum CustomError: Error {
    case invalidStatusCode
    
    var message: String {
        switch self {
        case .invalidStatusCode:
            return "Invalid status code."
        }
    }
}
