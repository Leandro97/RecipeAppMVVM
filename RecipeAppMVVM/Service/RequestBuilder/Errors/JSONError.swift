//
//  JSONError.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/06/24.
//

import Foundation

public enum JSONError: Error {
    case invalidData
    case invalidModelType
    
    var message: String {
        switch self {
        case .invalidData:
            return "Data is not a valid JSON object"
        case .invalidModelType:
            return "Cannot parse JSON to specified model"
        }
    }
}