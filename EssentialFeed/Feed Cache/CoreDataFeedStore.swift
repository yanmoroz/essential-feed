//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 05.12.2023.
//

import Foundation

public class CoreDataFeedStore: FeedStore {
    
    public init() {}
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage],
                       timestamp: Date,
                       completion: @escaping InsertionCompletion) {
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
}
