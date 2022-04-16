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
        let url = makeUrl()
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
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_create_should_complete_with_account_if_client_completes_with_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }
    
    func test_create_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }
    
    func test_create_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteCreateAccount? = RemoteCreateAccount(url: makeUrl(), httpClientPost: httpClientSpy)
        var result: (Result<AccountModel, DomainError>)?
        sut?.create(account: makeCreateAccountModel(), completion: { result = $0
        })
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteCreateAccountTests {
    
    func makeSut(url: URL = URL(string: "http://url.com")!, file: StaticString = #file, line: UInt = #line) -> (RemoteCreateAccount, HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteCreateAccount(url: url, httpClientPost: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteCreateAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.create(account: makeCreateAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) but received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
