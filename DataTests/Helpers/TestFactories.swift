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

func makeValidData() -> Data {
    return Data("{\"name\":\"Rafael\"}".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeUrl() -> URL {
    return URL(string: "http://url.com")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0, userInfo: ["any_dictionary":0])
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
