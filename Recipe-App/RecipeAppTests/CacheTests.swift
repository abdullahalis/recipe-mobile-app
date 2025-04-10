//
//  CacheTests.swift
//  RecipeAppTests
//
//  Created by Abdullah Ali on 4/10/25.
//

import XCTest
@testable import Recipe_App

final class CacheTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCacheAdd() {
        
        let cache = LRUCache<Int, String>(capacity: 5)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        
        XCTAssertFalse(cache.cache.isEmpty, "Cache should not be empty")
        XCTAssertEqual(cache.cache.count, 2, "Cache should have two elements")
        XCTAssertNotNil(cache.list.head, "LRU list head should not be nil")
        XCTAssertNotNil(cache.list.tail, "LRU list tail should not be nil")
    }
    
    func testCacheGet() {
        
        let cache = LRUCache<Int, String>(capacity: 5)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        
        XCTAssertEqual(cache.get(key: 1), "one", "Cache should not be empty")
        XCTAssertNil(cache.get(key: 3), "Cache should not include 3")
    }
    
    func testCacheRemove() {
        
        let cache = LRUCache<Int, Int>(capacity: 5)
        
        for i in 1...8 {
            print("i: \(i)")
            cache.set(key: i, value: i)
        }
        
        XCTAssertEqual(cache.cache.count, 5, "Cache should not go past max capacity")
        XCTAssertNil(cache.get(key: 2), "Cache should have evicted 2")
        XCTAssertEqual(cache.list.tail?.key, 4, "LRU at this point should be 4")
        XCTAssertEqual(cache.list.head?.key, 8, "MRU should be 8")
    }
    
    
    
    

}
