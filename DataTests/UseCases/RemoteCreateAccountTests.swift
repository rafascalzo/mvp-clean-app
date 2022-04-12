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
        sut.create(account: makeCreateAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_create_should_call_httpClentPost_with_correct_data() {
        // System under test
        let (sut, httpClientSpy) = makeSut()
        let createAccountModel = makeCreateAccountModel()
        sut.create(account: createAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, createAccountModel.toData())
    }
    
    func test_create_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.create(account: makeCreateAccountModel()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            default: XCTFail("Expected error but received \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
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
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
        }
    }
}
