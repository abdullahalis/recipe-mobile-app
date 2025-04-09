//
//  APIManagerTests.swift
//  RecipeAppTests
//
//  Created by Abdullah Ali on 4/7/25.
//

import XCTest
@testable import Recipe_App

final class APIManagerTests: XCTestCase {

//    override func setUpWithError() throws {
//        
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
    
    
    func testFetchDataValidEndpoint() async throws {
        let apiManager = APIManager(endpoint: "https://jsonplaceholder.typicode.com/users") // Test on fake json data
   
        do {
            let data = try await apiManager.fetchData()
            XCTAssertFalse(data.isEmpty, "Data should not be empty")
        } catch {
            XCTFail("Expected successful response, but got error: \(error)")
        }
    }
    
    func testFetchDataInvalidResponse() async throws {
        let apiManager = APIManager(endpoint: "https://httpstat.us/404")
   
        do {
            _ = try await apiManager.fetchData()
            XCTFail("Expected invalidResponse error")
        } catch let error as APIError {

            switch error {
                case .invalidResponse:
                    // Successfully caught response error
                    break
                default:
                    XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchDataInvalidEndpoint() async throws {
        let apiManager = APIManager(endpoint: "")
   
        do {
            _ = try await apiManager.fetchData()
            XCTFail("Expected invalidURL error")
        } catch let error as APIError {

            switch error {
                case .invalidURL:
                    // Successfully caught URL error
                    break
                case .invalidResponse:
                    print("invalid response instead of url")
                
                default:
                    XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
