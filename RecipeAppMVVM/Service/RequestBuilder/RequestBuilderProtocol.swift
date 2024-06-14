//
//  RequestBuilderProtocol.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 14/06/24.
//

import Foundation

protocol RequestBuilderProtocol {
    func makeRequest<T: Decodable>(
        domain: String,
        apiKey: String,
        method: HTTPMethod,
        endpoint: String,
        headers: [String: String]?,
        queryParameters: [URLQueryItem]?,
        bodyParameters: [String: Any]?,
        using dataModel: T.Type
    ) async throws -> T
    
    func makeRequest(
        domain: String,
        apiKey: String,
        method: HTTPMethod,
        endpoint: String,
        headers: [String: String]?,
        queryParameters: [URLQueryItem]?,
        bodyParameters: [String: Any]?
    ) async throws -> Data
}

// MARK: - Default parameter helpers
extension RequestBuilderProtocol {
    func makeRequest<T: Decodable>(
        domain: String = BaseUrl.domain,
        apiKey: String = BaseUrl.apiKey,
        method: HTTPMethod,
        endpoint: String,
        headers: [String: String]? = nil,
        queryParameters: [URLQueryItem]? = nil,
        bodyParameters: [String: Any]? = nil,
        using dataModel: T.Type
    ) async throws -> T {
        let model = try await self.makeRequest(
            domain: domain,
            apiKey: apiKey,
            method: method,
            endpoint: endpoint,
            headers: headers,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters,
            using: dataModel
        )
        
        return model
    }
    
    func makeRequest(
        domain: String = BaseUrl.domain,
        apiKey: String = BaseUrl.apiKey,
        method: HTTPMethod,
        endpoint: String,
        headers: [String: String]? = nil,
        queryParameters: [URLQueryItem]? = nil,
        bodyParameters: [String: Any]? = nil
    ) async throws -> Data {
        let data = try await self.makeRequest(
            domain: domain,
            apiKey: apiKey,
            method: method,
            endpoint: endpoint,
            headers: headers,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters
        )
        
        return data
    }
}
