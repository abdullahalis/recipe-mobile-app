//
//  RecipeViewModelTests.swift
//  RecipeAppTests
//
//  Created by Abdullah Ali on 4/7/25.
//

import XCTest
@testable import Recipe_App

final class RecipeViewModelTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    func testFullRecipes() async throws {
        let vm = await MainActor.run {RecipeViewModel(endpoint: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")}
        await vm.loadRecipes()
        
        let recipes = await vm.recipes
        let error = await vm.error
        let hasError = await vm.hasError
        
        XCTAssertTrue(type(of: recipes) == [Recipe].self, "Expected recipes to be an array of Recipe")
        XCTAssertFalse(recipes.isEmpty, "Expected recipes array to not be empty")
        XCTAssertNotNil(recipes.first?.name, "Expected first recipe to have a name")
        XCTAssertFalse(hasError, "Unexpected error: \(error?.localizedDescription ?? "unknown")")
    }
    
    func testMalformedRecipes() async throws {
        let vm = await MainActor.run {RecipeViewModel(endpoint: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")}
        await vm.loadRecipes()
        
        let recipes = await vm.recipes
        let error = await vm.error
        let hasError = await vm.hasError
        
        XCTAssertTrue(recipes.isEmpty, "Expected recipes array to be empty")
        XCTAssertTrue(hasError, "Expected error")
        XCTAssertEqual(error?.localizedDescription, "Could not decode the data.", "Expected decoding error, got \(error?.localizedDescription ?? "unknown")")
    }
    
    func testEmptyRecipes() async throws {
        let vm = await MainActor.run {RecipeViewModel(endpoint: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")}
        await vm.loadRecipes()
        
        let recipes = await vm.recipes
        let error = await vm.error
        let hasError = await vm.hasError
        
        XCTAssertTrue(recipes.isEmpty, "Expected recipes array to be empty")
        XCTAssertTrue(hasError, "Expected error")
        XCTAssertEqual(error?.localizedDescription, "Data is empty.", "Expected empty data error, got \(error?.localizedDescription ?? "unknown")")
    }
}
