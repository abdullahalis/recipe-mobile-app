//
//  CacheTests.swift
//  RecipeAppTests
//
//  Created by Abdullah Ali on 4/10/25.
//

import XCTest
@testable import Recipe_App

final class CacheTests: XCTestCase {
    
    
    func getImageUrls() async -> [String] {
        let vm = await RecipeViewModel()
        await vm.loadRecipes()
        
        var imageURLs: [String] = []
        for recipe in await vm.recipes {
            if let url = recipe.photoUrlLarge {
                imageURLs.append(url)
            }
        }
        return imageURLs
        
    }
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
    
    func testConcurrentAccess() {
        let expectation = XCTestExpectation(description: "Concurrent access completed")
        let cache = LRUCache<String, Int>(capacity: 10)
        let dispatchGroup = DispatchGroup()
        let concurrentQueue = DispatchQueue(label: "com.recipeapp.cache.concurrent", attributes: .concurrent)
        
        // 100 concurrent reads and writes
        let totalOps = 100
        
        for i in 0..<totalOps {
            dispatchGroup.enter()
            concurrentQueue.async {
                let key = "key\(i % 20)" // Overlap keys to test LRU eviction
                let value = i
                
                // 50% chance to write or read
                if Bool.random() {
                    cache.set(key: key, value: value)
                } else {
                    _ = cache.get(key: key)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // If the cache is still valid and contains at most the capacity, it passed
            XCTAssertLessThanOrEqual(cache.cache.count, 10, "Cache exceeded capacity, race condition likely.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testInsertionAndSize() {
        let cache = LRUCache<Int, String>(capacity: 5)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        
        XCTAssertEqual(cache.cache.count, 2, "Cache should have exactly 2 entries")
        XCTAssertEqual(cache.get(key: 1), "one", "Should return correct value for key 1")
        XCTAssertEqual(cache.get(key: 2), "two", "Should return correct value for key 2")
        XCTAssertNotNil(cache.list.head, "Head of LRU list should not be nil")
        XCTAssertNotNil(cache.list.tail, "Tail of LRU list should not be nil")
    }

    func testRetrievalUpdatesUsage() {
        let cache = LRUCache<Int, String>(capacity: 3)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        cache.set(key: 3, value: "three")
        
        // Access key 1 to mark it as most recently used
        _ = cache.get(key: 1)
        cache.set(key: 4, value: "four") // Should evict key 2 (least recently used)
        
        XCTAssertNil(cache.get(key: 2), "Key 2 should have been evicted")
        XCTAssertEqual(cache.get(key: 1), "one", "Key 1 should still be in cache")
        XCTAssertEqual(cache.list.head?.key, 1, "Most recently used should be key 1")
        XCTAssertEqual(cache.list.tail?.key, 3, "Least recently used should now be key 3")
    }
    
    func testEvictionWhenOverCapacity() {
        let cache = LRUCache<Int, Int>(capacity: 5)
        for i in 1...8 {
            cache.set(key: i, value: i)
        }
        
        XCTAssertEqual(cache.cache.count, 5, "Cache should not exceed its capacity")
        XCTAssertNil(cache.get(key: 1), "Key 1 should have been evicted")
        XCTAssertEqual(cache.get(key: 8), 8, "Most recent key should be retained")
        XCTAssertEqual(cache.list.head?.key, 8, "Head of LRU list should be key 8")
        XCTAssertEqual(cache.list.tail?.key, 4, "Tail should be the least recently used (key 4)")
    }

    func testUpdateMovesToFront() {
        let cache = LRUCache<Int, String>(capacity: 3)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        cache.set(key: 3, value: "three")
        
        cache.set(key: 2, value: "TWO") // Updating value should move it to front
        
        XCTAssertEqual(cache.list.head?.key, 2, "Updated key should become most recently used")
        XCTAssertEqual(cache.get(key: 2), "TWO", "Updated value should be stored")
    }

    func testInsertAndEvictRepeatedKeys() {
        let cache = LRUCache<Int, String>(capacity: 2)
        cache.set(key: 1, value: "one")
        cache.set(key: 2, value: "two")
        cache.set(key: 1, value: "ONE")
        cache.set(key: 3, value: "three") // Evicts key 2
        
        XCTAssertEqual(cache.get(key: 1), "ONE", "Key 1 should still be in cache")
        XCTAssertNil(cache.get(key: 2), "Key 2 should have been evicted")
        XCTAssertEqual(cache.get(key: 3), "three", "Key 3 should be present")
    }

    func testEmptyCacheReturnsNil() {
        let cache = LRUCache<Int, String>(capacity: 3)
        XCTAssertNil(cache.get(key: 99), "Cache should return nil for non-existent key")
    }
    
    func testLoadImagesWithoutCachePerformance() async {
        var testURLs = await getImageUrls()
        let apiManager = APIManager()
        
        measure {
            let expectation = XCTestExpectation(description: "Load images async")
            let group = DispatchGroup()

            for url in testURLs {
                group.enter()
                
                Task {
                    do {
                        let data = try await apiManager.fetchData(endpoint: url)
                        let image = UIImage(data: data)
                    } catch {
                        
                    }
                    
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 10)
        }
    }

        func testLoadImagesWithCachePerformance() async {
            var testURLs = await getImageUrls()
            let apiManager = APIManager()
            let imageCache = LRUCache<String, UIImage>(capacity: 100)
            
            for url in testURLs {
                
                Task {
                    do {
                        let data = try await apiManager.fetchData(endpoint: url)
                        let image = UIImage(data: data)
                        imageCache.set(key: url, value: image!)
                    } catch {
                        
                    }
                }
            }
            
            measure {
                let expectation = XCTestExpectation(description: "Load images from cache")
                let group = DispatchGroup()

                for url in testURLs {
                    group.enter()
                    
                    if let image = imageCache.get(key: url) {
                        group.leave()
                    } else {
                        Task {
                            do {
                                let data = try await apiManager.fetchData(endpoint: url)
                                let image = UIImage(data: data)
                            } catch {
                                
                            }
                            group.leave()
                        }
                    }
                    
                }

                group.notify(queue: .main) {
                    expectation.fulfill()
                }

                wait(for: [expectation], timeout: 10)
            }
        }

}
