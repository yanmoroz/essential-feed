//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Yan Moroz on 04.12.2023.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
    
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        let exp = expectation(description: "Waiting for cache insertion")
        var insertionError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
            insertionError = receivedInsertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    
    @discardableResult
    func deleteCache(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "Waiting for cache deletion")
        var deletionError: Error?
        sut.deleteCachedFeed { error in
            deletionError = error
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        return deletionError
    }
    
    func expect(_ sut: FeedStore,
                toRetrieveTwice expectedResult: RetrieveCachedFeedResult,
                file: StaticString = #file,
                line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult)
    }
    
    func expect(_ sut: FeedStore,
                toRetrieve expectedResult: RetrieveCachedFeedResult,
                file: StaticString = #file,
                line: UInt = #line) {
        let exp = expectation(description: "Waiting for cache retrieval")
        sut.retrieve { retrievadResult in
            switch (expectedResult, retrievadResult) {
            case (.empty, .empty), (.failure, .failure):
                break
            case let (.found(expectedFeed, expectedTimestamp), .found(retrievadFeed, retrievadTimestamp)):
                XCTAssertEqual(expectedFeed, retrievadFeed, file: file, line: line)
                XCTAssertEqual(expectedTimestamp, retrievadTimestamp, file: file, line: line)
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievadResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}
