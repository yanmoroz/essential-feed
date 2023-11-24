//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 24.11.2023.
//

import Foundation

public protocol HTTPClient {
    
    typealias Completion = (Result<(Data, HTTPURLResponse), Error>) -> Void
    
    func get(from url : URL,
             completion: @escaping Completion
    )
}
