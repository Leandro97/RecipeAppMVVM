//
//  HomeViewModelTests.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 25/06/24.
//

@testable import RecipeAppMVVM
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var sessionHandler: URLSessionHandlerProtocol!
    private var requestBuilder: RequestBuilder!
    private var service: RecipeService!
    private var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        sessionHandler = URLSessionHandlerMock()
        requestBuilder = RequestBuilder(with: sessionHandler)
        service = RecipeService(requestBuilder: requestBuilder)
        viewModel = HomeViewModel(service: service)
    }
    
    override func tearDown() {
        sessionHandler = nil
        requestBuilder = nil
        service = nil
        viewModel = nil
    }
    
    func testFailedGetRandomRecipes() async throws {
        XCTAssertFalse(viewModel.isLoading)
        defer { XCTAssertFalse(viewModel.isLoading) }
        
        await viewModel.getRandomRecipes()
        XCTAssertTrue(viewModel.recipeList.isEmpty)
        XCTAssertTrue(viewModel.hasError)
    }
    
    func testSuccessfulGetRandomRecipes() async throws {
        let mockFile = "recipe-list-mock"
        sessionHandler.jsonFile = mockFile
        
        XCTAssertFalse(viewModel.isLoading)
        defer { XCTAssertFalse(viewModel.isLoading) }
        
        await viewModel.getRandomRecipes()
        XCTAssertFalse(viewModel.recipeList.isEmpty)
        XCTAssertFalse(viewModel.hasError)
        
        let mockData = try! JSONLoader.load(from: mockFile)
        let mockObject = try! JSONDecoder().decode(RecipeList.self, from: mockData)
        XCTAssertEqual(viewModel.recipeList, mockObject.recipes)
    }
}
