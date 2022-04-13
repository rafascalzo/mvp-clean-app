//
//  TestFactories.swift
//  DataTests
//
//  Created by Rafael Scalzo on 13/04/22.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://url.com")!
}
