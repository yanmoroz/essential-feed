//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Yan Moroz on 27.11.2023.
//

import Foundation

final public class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    struct UnexpectedValuesRepresentation: Error { }
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                      let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
