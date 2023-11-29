//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
