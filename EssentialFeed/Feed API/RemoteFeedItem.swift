//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 30.11.2023.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
