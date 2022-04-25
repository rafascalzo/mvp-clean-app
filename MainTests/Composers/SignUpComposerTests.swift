//
//  SignUpComposerTests.swift
//  SignUpComposerTests
//
//  Created by Rafael Scalzo on 19/04/22.
//

import XCTest
import Main

class SignUpComposerTests: XCTestCase {

    func test_ui_presentation_integration()  {
        let sut = SignUpComposer.composeController(with: CreateAccountSpy())
        checkMemoryLeak(for: sut)
    }
}
