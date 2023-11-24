//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

protocol FeedLoader {
    
    typealias Completion = (Result<[FeedItem], Error>) -> Void
    
    func load(completion: @escaping Completion)
}
