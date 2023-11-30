//
//  CodableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Yan Moroz on 30.11.2023.
//

import XCTest
import EssentialFeed

class CodableFeedStore {
    
    private let storeURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first!.appendingPathComponent("image-feed.store")
    }()
    
    private struct Cache: Codable {
        let feed: [LocalFeedImage]
        let timestamp: Date
    }
    
    func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
        
        let decoder = JSONDecoder()
        let decode = try! decoder.decode(Cache.self, from: data)
        
        completion(.found(feed: decode.feed, timestamp: decode.timestamp))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(Cache(feed: feed, timestamp: timestamp))
        try! encoded.write(to: storeURL)
        completion(nil)
    }
}

final class CodableFeedStoreTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let storeURL = urls.first!.appendingPathComponent("image-feed.store")
        try? FileManager.default.removeItem(at: storeURL)
    }
    
    override func tearDown() {
        super.tearDown()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let storeURL = urls.first!.appendingPathComponent("image-feed.store")
        try? FileManager.default.removeItem(at: storeURL)
    }
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = CodableFeedStore()
        
        let exp = expectation(description: "Waiting for cache retrieval")
        sut.retrieve { result in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result, got result: \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = CodableFeedStore()
        
        let exp = expectation(description: "Waiting for cache retrieval")
        sut.retrieve { firstResult in
            sut.retrieve { secondResult in
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                default:
                    XCTFail("Expected retrieving twice from empty cache to deliver same empty result, got results: \(firstResult) and \(secondResult) instead")
                }
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieveAfterInsertingToEmptyCache_deliversInsertedValues() {
        let sut = CodableFeedStore()
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        let exp = expectation(description: "Waiting for cache retrieval")
        sut.insert(feed, timestamp: timestamp) { insertionError in
            XCTAssertNil(insertionError, "Expected feed to be inserted successfully")
            sut.retrieve { retrieveResult in
                switch retrieveResult {
                case let .found(retrievedFeed, retrievedTimestamp):
                    XCTAssertEqual(retrievedFeed, feed)
                    XCTAssertEqual(retrievedTimestamp, timestamp)
                default:
                    XCTFail("Expected found result with feed: \(feed) and timestamp: \(timestamp), got result: \(retrieveResult) instead")
                }
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1.0)
    }
}
