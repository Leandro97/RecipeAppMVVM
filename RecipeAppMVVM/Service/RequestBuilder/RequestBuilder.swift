//
//  RequestBuilder.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/06/24.
//

import Foundation

class RequestBuilder {
    static func makeRequest(
        domain: String = BaseUrl.domain,
        apiKey: String = BaseUrl.apiKey,
        method: HTTPMethod,
        endpoint: String,
        headers: [String: String]? = nil,
        queryParameters: [URLQueryItem]? = nil,
        bodyParameters: [String: Any]? = nil
    ) async throws -> Data {
        let request = try Self.formattedRequest(
            domain,
            apiKey,
            method,
            endpoint,
            headers,
            queryParameters,
            bodyParameters
        )
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200,
            response.statusCode <= 300
        else {
            let response = response as? HTTPURLResponse
            throw CustomError.invalidStatusCode(response?.statusCode ?? 404)
        }
        
        return data
    }
}

extension RequestBuilder {
    private static func formattedRequest(
        _ domain: String = BaseUrl.domain,
        _ apiKey: String = BaseUrl.apiKey,
        _ method: HTTPMethod,
        _ endpoint: String,
        _ headers: [String: String]?,
        _ queryParameters: [URLQueryItem]?,
        _ bodyParameters: [String: Any]?
    ) throws -> URLRequest {
        if method == .get && bodyParameters != nil {
            throw CustomError.bodyNotAllowed
        }
        
        guard
            let urlComponents = NSURLComponents(string: "\(domain)/\(endpoint)")
        else { throw CustomError.invalidUrl }
        
        // MARK: Query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        queryParameters?.forEach { item in
            urlComponents.queryItems?.append(item)
        }
        
        // MARK: HTTP Method
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue
        
        // MARK: Headers
        headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // MARK: Body
        if let bodyParameters {
            let bodyData = try? JSONSerialization.data(withJSONObject: bodyParameters)
            request.httpBody = bodyData
        }
        
        return request
    }
}
