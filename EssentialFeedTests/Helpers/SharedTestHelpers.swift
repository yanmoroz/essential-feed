//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Yan Moroz on 30.11.2023.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
