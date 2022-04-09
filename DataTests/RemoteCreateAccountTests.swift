//
//  RemoteCreateAccountTests.swift
//  RemoteCreateAccountTestsTests
//
//  Created by rvs on 11/02/22.
//

import XCTest
// @testable import Data
import Domain

class RemoteCreateAccount {
    
    private let url: URL
    private let httpClientPost: HttpClientPost
    
    init (url: URL, httpClientPost: HttpClientPost) {
        self.url = url
        self.httpClientPost = httpClientPost
    }
    
    func create(createAccountModel: CreateAccountModel) {
        httpClientPost.post(to: url, with: createAccountModel.toData())
    }
}
 
protocol HttpClientPost {
    func post(to url: URL, with data: Data?)
}

class RemoteCreateAccountTests: XCTestCase {

    func test_create_should_call_httpClentPost_with_correct_url() {
        let url = URL(string: "http://url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.create(createAccountModel: makeCreateAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_create_should_call_httpClentPost_with_correct_data() {
        // System under test

        let (sut, httpClientSpy) = makeSut()
        let createAccountModel = makeCreateAccountModel()
        sut.create(createAccountModel: createAccountModel)
        XCTAssertEqual(httpClientSpy.data, createAccountModel.toData())
    }
}

extension RemoteCreateAccountTests {
    
    func makeSut(url: URL = URL(string: "http://url.com")!) -> (RemoteCreateAccount, HttpClientSpy) {
        // System under test
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteCreateAccount(url: url, httpClientPost: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeCreateAccountModel() -> CreateAccountModel {
        return CreateAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password_confirmation")
    }
    
    class HttpClientSpy: HttpClientPost {
        
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}
