//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

public protocol HTTPClient {
    func get(from url : URL)
}

public final class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
}
