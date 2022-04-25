//
//  SignUpComposerTests.swift
//  SignUpComposerTests
//
//  Created by Rafael Scalzo on 19/04/22.
//

import XCTest
import Main
import UI

class SignUpComposerTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread()  {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()
       
    }
}

extension SignUpComposerTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, createAccount: CreateAccountSpy) {
        let createAccountSpy = CreateAccountSpy()
        let sut = SignUpComposer.composeController(with: createAccountSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: createAccountSpy, file: file, line: line)
        return (sut, createAccountSpy)
    }
}
