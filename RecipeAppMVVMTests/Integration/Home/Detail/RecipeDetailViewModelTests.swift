//
//  RecipeDetailViewModelTests.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 26/06/24.
//

@testable import RecipeAppMVVM
import XCTest

final class RecipeDetailViewModelTests: XCTestCase {
    private var sessionHandler: URLSessionHandlerProtocol!
    private var requestBuilder: RequestBuilder!
    private var service: RecipeService!
    private var viewModel: RecipeDetailViewModel!
    
    override func setUpWithError() throws {
        sessionHandler = URLSessionHandlerMock()
        requestBuilder = RequestBuilder(with: sessionHandler)
        service = RecipeService(requestBuilder: requestBuilder)
        viewModel = RecipeDetailViewModel(service: service)
    }
    
    override func tearDown() {
        sessionHandler = nil
        requestBuilder = nil
        service = nil
        viewModel = nil
    }
    
    func testFailedGetRandomRecipes() async throws {
        XCTFail()
    }
}
