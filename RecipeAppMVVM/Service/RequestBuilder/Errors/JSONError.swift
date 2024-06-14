//
//  JSONError.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/06/24.
//

import Foundation

public enum JSONError: Error, Equatable {
    case invalidData
    case invalidModelType
    case fileError(_ message: String)
    
    var message: String {
        switch self {
        case .invalidData:
            return "Data is not a valid JSON object"
        case .invalidModelType:
            return "Cannot parse JSON to specified model"
        case .fileError(let message):
            return message
        }
    }
}
