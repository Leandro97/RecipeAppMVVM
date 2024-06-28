//
//  RecipeServiceTests.swift
//  RecipeAppMVVMTests
//
//  Created by Leandro Martins de Freitas on 14/06/24.
//

import XCTest
@testable import RecipeAppMVVM

final class RecipeServiceTests: XCTestCase {
    private var sessionHandler: URLSessionHandlerProtocol!
    private var requestBuilder: RequestBuilder!
    private var service: RecipeServiceProtocol!
    
    override func setUpWithError() throws {
        sessionHandler = URLSessionHandlerMock()
        requestBuilder = RequestBuilder(with: sessionHandler)
        service = RecipeService(requestBuilder: requestBuilder)
    }
    
    func testGetRandomRecipes() async throws {
        sessionHandler.jsonFile = "recipe-list-mock"
        
        let recipeList = try await service.getRandomRecipes(quantity: 1, dishType: nil, diet: nil)
        XCTAssertFalse(recipeList.isEmpty)
        XCTAssertEqual(recipeList.first?.title, "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs")
    }
    
    func testEmptyGetSimilarRecipe() async {
        sessionHandler.jsonFile = "empty-similar-recipe-list"
        
        do {
            _ = try await service.getSimilarRecipe(with: 1)
        } catch {
            let customError = error as? HTTPRequestError
            XCTAssertEqual(customError, HTTPRequestError.noContent)
        }
    }
    
    func testSuccessfulGetSimilarRecipe() async throws {
        sessionHandler.jsonFile = "similar-recipe-list"
        
        let recipeId = try await service.getSimilarRecipe(with: 1)
        XCTAssertNotNil(recipeId)
    }
    
    func testFailedGetRecipe() async {
        let recipeId = 999
        sessionHandler.jsonFile = "recipe"
        
        do {
            _ = try await service.getRecipe(with: recipeId)
        } catch {
            let customError = error as? HTTPRequestError
            XCTAssertEqual(customError, HTTPRequestError.invalidStatusCode(404))
        }
    }

    func testSuccessfulGetRecipe() async throws {
        let recipeId = 1
        sessionHandler.jsonFile = "recipe"
        
        let recipe = try await service.getRecipe(with: recipeId)
        XCTAssertEqual(recipe.id, 1)
    }
}
