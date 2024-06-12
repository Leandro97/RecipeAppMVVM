//
//  CustomError.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 13/12/23.
//

import Foundation

public enum CustomError: Error {
    case invalidUrl
    case invalidStatusCode(_ code: Int)
    case bodyNotAllowed
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidStatusCode:
            return "Invalid status code"
        case .bodyNotAllowed:
            return "GET requests should not use body data"
        }
    }
}
