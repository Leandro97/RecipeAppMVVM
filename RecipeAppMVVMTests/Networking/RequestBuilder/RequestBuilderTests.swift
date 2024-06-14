//
//  RequestBuilderTests.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 14/06/24.
//

@testable import RecipeAppMVVM
import XCTest

final class RequestBuilderTests: XCTestCase {
    var requestBuilder: RequestBuilder!
    
    override func setUpWithError() throws {
        requestBuilder = RequestBuilder(with: URLSessionHandlerMock())
    }
    
    func testInvalidUrl() async {
        do {
            _ = try await requestBuilder.makeRequest(
                domain: "abc",
                method: .get,
                endpoint: ""
            )
        } catch {
            let customError = error as? HTTPRequestError
            XCTAssertEqual(customError, HTTPRequestError.invalidUrl)
        }
    }
    
    func testInvalidBody() async {
        do {
            _ = try await requestBuilder.makeRequest(
                method: .get,
                endpoint: "",
                bodyParameters: ["name": "A"]
            )
        } catch {
            let customError = error as? HTTPRequestError
            XCTAssertEqual(customError, HTTPRequestError.bodyNotAllowed)
        }
    }
    
    func testInvalidStatusCode() async throws {
        do {
            _ = try await requestBuilder.makeRequest(
                method: .get,
                endpoint: "invalidEndpoint"
            )
        } catch {
            let customError = error as? HTTPRequestError
            XCTAssertEqual(customError, HTTPRequestError.invalidStatusCode(404))
        }
    }
    
    func testSuccessfulRequestWithoutType() async throws {
        _ = try await requestBuilder.makeRequest(
            method: .post,
            endpoint: "",
            bodyParameters: ["name": "A"]
        )
    }
    
    func testInvalidResponseData() async throws {
        do {
            _ = try await requestBuilder.makeRequest(
                method: .get,
                endpoint: "",
                using: SimilarRecipeObject.self
            )
        } catch {
            let customError = error as? JSONError
            XCTAssertEqual(customError, JSONError.invalidData)
        }
    }
    
    func testRequestWithInvalidType() async throws {
        do {
            _ = try await requestBuilder.makeRequest(
                method: .get,
                endpoint: "recipes/random",
                using: Recipe.self
            )
        } catch {
            let customError = error as? JSONError
            XCTAssertEqual(customError, JSONError.invalidModelType)
        }
    }
    
    func testRequestWithValidType() async throws {
        let recipes = try await requestBuilder.makeRequest(
            method: .get,
            endpoint: "recipes/random",
            using: [Recipe].self
        )
        
        XCTAssertFalse(recipes.isEmpty)
    }
}
