//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

public protocol HTTPClient {
    func get(from url : URL,
             completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

public final class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
