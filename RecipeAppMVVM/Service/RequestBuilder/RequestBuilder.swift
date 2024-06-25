//
//  RequestBuilder.swift
//  RecipeAppMVVM
//
//  Created by Leandro Martins de Freitas on 12/06/24.
//

import Foundation

protocol URLSessionHandlerProtocol {
    var jsonFile: String { get set }
    
    func getData(for request: URLRequest) async throws -> (Data, URLResponse)
}

private class DefaultURLSessionHandler: URLSessionHandlerProtocol {
    var jsonFile = ""
    
    func getData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: request)
    }
}

class RequestBuilder: RequestBuilderProtocol {
    private var urlSessionHandler: URLSessionHandlerProtocol
    static let shared = RequestBuilder(with: DefaultURLSessionHandler())
    
    init(with urlSessionHandler: URLSessionHandlerProtocol) {
        self.urlSessionHandler = urlSessionHandler
    }
    
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
        let data = try await makeRequest(
            domain: domain,
            apiKey: apiKey,
            method: method,
            endpoint: endpoint,
            headers: headers,
            queryParameters: queryParameters,
            bodyParameters: bodyParameters
        )
        
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch {
            let decodingError = error as? DecodingError
            
            if decodingError.debugDescription.contains("The given data was not valid JSON.") {
                throw JSONError.invalidData
            } else {
                throw JSONError.invalidModelType
            }
        }
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
        let request = try self.formattedRequest(
            domain,
            apiKey,
            method,
            endpoint,
            headers,
            queryParameters,
            bodyParameters
        )
        
        let (data, response) = try await urlSessionHandler.getData(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200,
            response.statusCode <= 300
        else {
            let response = response as? HTTPURLResponse
            throw HTTPRequestError.invalidStatusCode(response?.statusCode ?? 404)
        }
        
        return data
    }
}

extension RequestBuilder {
    private func formattedRequest(
        _ domain: String = BaseUrl.domain,
        _ apiKey: String = BaseUrl.apiKey,
        _ method: HTTPMethod,
        _ endpoint: String,
        _ headers: [String: String]?,
        _ queryParameters: [URLQueryItem]?,
        _ bodyParameters: [String: Any]?
    ) throws -> URLRequest {
        if method == .get && bodyParameters != nil {
            throw HTTPRequestError.bodyNotAllowed
        }
        
        var urlString: String {
            if endpoint.isEmpty {
                return domain
            } else {
                return "\(domain)/\(endpoint)"
            }
        }
        
        guard
            let urlComponents = NSURLComponents(string: urlString)
        else { throw HTTPRequestError.invalidUrl }
        
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
