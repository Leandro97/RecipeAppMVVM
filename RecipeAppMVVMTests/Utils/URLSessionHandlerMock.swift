//
//  URLSessionHandlerMock.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 14/06/24.
//

@testable import RecipeAppMVVM
import XCTest

final class URLSessionHandlerMock: URLSessionHandlerProtocol {
    var jsonFile = ""
    
    func getData(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let url = request.url else { throw HTTPRequestError.invalidUrl }
        
        if !isValidUrl(url.absoluteString) {
            throw HTTPRequestError.invalidUrl
        }
        
        if
            url.absoluteString.contains("invalidEndpoint")
            || url.absoluteString.contains("recipes/999/information")
        {
            throw HTTPRequestError.invalidStatusCode(404)
        }
        
        var data: Data {
            if !jsonFile.isEmpty, let data = try? JSONLoader.load(from: jsonFile) {
                return data
            } else {
                return Data()
            }
        }
        
        return (
            data,
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        )
    }
}

extension URLSessionHandlerMock {
    private func isValidUrl(_ urlString: String?) -> Bool {
        guard
            let urlString = urlString,
            let url = URL(string: urlString)
        else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(url)
    }
}
