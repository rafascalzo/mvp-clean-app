//
//  RemoteCreateAccountTests.swift
//  RemoteCreateAccountTestsTests
//
//  Created by rvs on 11/02/22.
//

import XCTest
// @testable import Data
@testable import Domain

class RemoteCreateAccount {
    
    private let url: URL
    private let httpClient: HttpClient
    
    init (url: URL, httpClient: HttpClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func create() {
        httpClient.post(url: url)
    }
}

protocol HttpClient {
     
    func post(url: URL)
}

class RemoteCreateAccountTests: XCTestCase {

   
    func testUrl() {
        let url = URL(string: "http://url.com")!
        // System under test
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteCreateAccount(url: url, httpClient: httpClientSpy)
        sut.create()
        XCTAssertEqual(httpClientSpy.url, url)
        
    }
    
    class HttpClientSpy: HttpClient {
        
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }

}
