//
//  RemoteCreateAccountTests.swift
//  RemoteCreateAccountTestsTests
//
//  Created by rvs on 11/02/22.
//

import XCTest
import Data
import Domain

class RemoteCreateAccountTests: XCTestCase {

    func test_create_should_call_httpClentPost_with_correct_url() {
        let url = URL(string: "http://url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.create(createAccountModel: makeCreateAccountModel())
        XCTAssertEqual(httpClientSpy.urls, [url])
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
        
        init() { }
        
        var urls = [URL]()
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.urls.append(url)
            self.data = data
        }
    }
}
