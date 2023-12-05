//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
