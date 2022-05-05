//
//  EmailValidatorAdapterTests.swift
//  EmailValidatorAdapterTests
//
//  Created by Rafael Scalzo on 18/04/22.
//

import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "rafael@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "rafael@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "rafael@yahoo.com"))
        XCTAssertTrue(sut.isValid(email: "rafael@live.com"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
