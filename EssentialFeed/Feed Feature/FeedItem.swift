//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 22.11.2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
 
