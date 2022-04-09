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
    private let httpClientPost: HttpClientPost
    
    init (url: URL, httpClientPost: HttpClientPost) {
        self.url = url
        self.httpClientPost = httpClientPost
    }
    
    func create(accountMModel: CreateAccountModel) {
        httpClientPost.post(url: url)
    }
}
 
protocol HttpClientPost {
    func post(url: URL)
}

class RemoteCreateAccountTests: XCTestCase {

    func test_create_should_call_httpClentPost_with_correct_url() {
        let url = URL(string: "http://url.com")!
        // System under test
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteCreateAccount(url: url, httpClientPost: httpClientSpy)
        sut.create()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_create_should_call_httpClentPost_with_correct_data() {
        // System under test
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteCreateAccount(url: URL(string: "http://url.com")!, httpClientPost: httpClientSpy)
        sut.create()
        XCTAssertEqual(httpClientSpy.data, data)
    }
}

extension RemoteCreateAccountTests {
    
    class HttpClientSpy: HttpClientPost {
        
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }
}
