//
//  HTTPRequestError.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 13/12/23.
//

import Foundation

public enum HTTPRequestError: Error, Equatable {
    case invalidUrl
    case invalidStatusCode(_ code: Int)
    case bodyNotAllowed
    case noContent
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidStatusCode:
            return "Invalid status code"
        case .bodyNotAllowed:
            return "GET requests should not use body data"
        case .noContent:
            return "Request has no content"
        }
    }
}
